# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :messages, dependent: :destroy

  belongs_to :owner, class_name: 'User'

  validates :name, :owner_id, presence: true
  validates :name, length: { maximum: 30 }, uniqueness: true

  # SET work_mem='100MB';
  def self.order_by_group(user_id, favourite_first = false)
    channels_order_by_message = <<-SQL
    /* creating helping table sorted by last message date  */
    WITH channels_by_last_message_desc AS (
                           SELECT channel_id
                           FROM messages
                           GROUP BY channel_id
                           ORDER BY max(created_at) DESC
    ), messages_by_channel_id AS (
                           SELECT * FROM (
                               SELECT ROW_NUMBER() OVER (PARTITION BY channel_id ORDER BY created_at) AS number, 
                                      messages.* 
                               FROM messages       
                           ) partition_messages
                           WHERE partition_messages.number <= ?
    )
    SELECT channels.* FROM channels
    LEFT JOIN channels_by_last_message_desc
    ON channels.id = channels_by_last_message_desc.channel_id
    LEFT JOIN memberships
    ON memberships.channel_id = channels.id
    ON memberships.user_id = ?
    SQL

    order_by_favourite = <<-SQL
    /* convert boolean to integer and sort */
    ORDER BY (
             CASE WHEN memberships.is_favorite = 't' THEN 1
             WHEN memberships.is_favorite = 'f' THEN 0
             ELSE 0
             END
    ) DESC
    SQL

    query = case favourite_first
            when true
              [channels_order_by_message, order_by_favourite, ';'].join('')
            else
              [channels_order_by_message, ';'].join('')
            end

    query.gsub!("\"", "\'") # PG doesn't accept double quotes ¯\_(ツ)_/¯

    Channel.find_by_sql([query, user_id])
  end

  def self.order_by_distinct(user_id, favourite_first = false)
    channels_order_by_message = <<-SQL
    /* creating helping table sorted by last message date  */
    WITH channels_by_last_message_desc AS (
        SELECT channel_id, created_at FROM (
            SELECT DISTINCT ON (channel_id) channel_id, created_at
            FROM messages
            ORDER BY channel_id, created_at DESC
        ) t
    ORDER BY created_at DESC
    )
    SELECT channels.* FROM channels
    LEFT JOIN channels_by_last_message_desc
    ON channels.id = channels_by_last_message_desc.channel_id
    LEFT JOIN memberships
    ON memberships.channel_id = channels.id
    LEFT JOIN users
    ON memberships.user_id = users.id
    WHERE users.id = ?
    SQL

    order_by_favourite = <<-SQL
    /* convert boolean to integer and sort */
    ORDER BY (
             CASE WHEN memberships.is_favorite = 't' THEN 1
             WHEN memberships.is_favorite = 'f' THEN 0
             ELSE 0
             END
    ) DESC
    SQL

    query = case favourite_first
            when true
              [channels_order_by_message, order_by_favourite, ';'].join('')
            else
              [channels_order_by_message, ';'].join('')
            end

    query.gsub!("\"", "\'") # PG doesn't accept double quotes ¯\_(ツ)_/¯

    Channel.find_by_sql([query, user_id])
  end
end

EXPLAIN ANALYZE
SELECT memberships.channel_id
FROM (
         SELECT DISTINCT ON (channel_id) channel_id, created_at
         FROM messages
         ORDER BY channel_id, created_at DESC
) AS t
LEFT JOIN memberships
ON memberships.user_id = t.user_id
AND memberships.channel_id = t.channel_id
GROUP BY memberships.channel_id, t.message_created_at;

LEFT JOINS messages ON messages.user_id = memberships.user_id
