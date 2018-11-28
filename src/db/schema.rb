# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_05_201106) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'access_tokens', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'essence', null: false
    t.string 'fingerprint_hash', null: false
    t.string 'ip', null: false
    t.datetime 'expires_at', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.uuid 'user_id'
    t.index ['user_id'], name: 'index_access_tokens_on_user_id'
  end

  create_table 'channel_options', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id', null: false
    t.uuid 'channel_id', null: false
    t.boolean 'is_favorite', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['channel_id'], name: 'index_channel_options_on_channel_id'
    t.index %w[user_id channel_id], name: 'index_channel_options_on_user_id_and_channel_id', unique: true
    t.index ['user_id'], name: 'index_channel_options_on_user_id'
  end

  create_table 'channels', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', limit: 30
    t.uuid 'owner_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['owner_id'], name: 'index_channels_on_owner_id'
  end

  create_table 'messages', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'user_id', null: false
    t.uuid 'channel_id', null: false
    t.string 'message_type', default: 'plain', null: false
    t.text 'text'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['channel_id'], name: 'index_messages_on_channel_id'
    t.index ['user_id'], name: 'index_messages_on_user_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'username', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['username'], name: 'index_users_on_username', unique: true
  end

  add_foreign_key 'access_tokens', 'users'
  add_foreign_key 'channel_options', 'channels'
  add_foreign_key 'channel_options', 'users'
  add_foreign_key 'channels', 'users', column: 'owner_id'
  add_foreign_key 'messages', 'channels'
  add_foreign_key 'messages', 'users'
end
