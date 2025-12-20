-- =====================================================
-- 000_nuke.sql - DROP ALL TABLES AND FUNCTIONS
-- ⚠️  WARNING: This will DELETE ALL DATA!
-- Only use for testing/development reset
-- =====================================================

-- =====================================================
-- DROP ALL POLICIES (by table)
-- =====================================================

-- Policies on recruitment_applications (005_parties.sql)
DROP POLICY IF EXISTS "Anyone can submit applications" ON recruitment_applications;
DROP POLICY IF EXISTS "Officers can manage applications" ON recruitment_applications;
DROP POLICY IF EXISTS "Officers can update applications" ON recruitment_applications;

-- Policies on party_roster (005_parties.sql)
DROP POLICY IF EXISTS "Clan members can view roster" ON party_roster;
DROP POLICY IF EXISTS "Officers can manage roster" ON party_roster;

-- Policies on parties (005_parties.sql)
DROP POLICY IF EXISTS "Clan members can view parties" ON parties;
DROP POLICY IF EXISTS "Officers can manage parties" ON parties;

-- Policies on announcements (003_events.sql)
DROP POLICY IF EXISTS "Clan members can view announcements" ON announcements;
DROP POLICY IF EXISTS "Officers+ can create announcements" ON announcements;
DROP POLICY IF EXISTS "Officers+ can update announcements" ON announcements;
DROP POLICY IF EXISTS "Officers+ can delete announcements" ON announcements;

-- Policies on event_rsvps (003_events.sql)
DROP POLICY IF EXISTS "Clan members can view RSVPs" ON event_rsvps;
DROP POLICY IF EXISTS "Members can RSVP" ON event_rsvps;
DROP POLICY IF EXISTS "Users can update own RSVP" ON event_rsvps;
DROP POLICY IF EXISTS "Users can delete own RSVP" ON event_rsvps;

-- Policies on events (003_events.sql)
DROP POLICY IF EXISTS "Clan members can view events" ON events;
DROP POLICY IF EXISTS "Officers+ can create events" ON events;
DROP POLICY IF EXISTS "Officers+ can update events" ON events;
DROP POLICY IF EXISTS "Officers+ can delete events" ON events;

-- Policies on member_professions (001_initial_schema.sql)
DROP POLICY IF EXISTS "View professions if can view member" ON member_professions;
DROP POLICY IF EXISTS "Modify professions" ON member_professions;

-- Policies on members (001_initial_schema.sql)
DROP POLICY IF EXISTS "Approved members can view members" ON members;
DROP POLICY IF EXISTS "Admin/Officer manage members" ON members;
DROP POLICY IF EXISTS "Admin/Officer update members" ON members;
DROP POLICY IF EXISTS "Admin/Officer delete members" ON members;

-- Policies on clan_members (001_initial_schema.sql + 006_fix_rls_recursion.sql)
DROP POLICY IF EXISTS "Users can view own membership" ON clan_members;
DROP POLICY IF EXISTS "Clan managers can view members" ON clan_members;
DROP POLICY IF EXISTS "Anyone can apply to clan" ON clan_members;
DROP POLICY IF EXISTS "Creator becomes admin" ON clan_members;
DROP POLICY IF EXISTS "Admin/Officer manage memberships" ON clan_members;
DROP POLICY IF EXISTS "Admin can remove or user can leave" ON clan_members;
-- New policy names from 006
DROP POLICY IF EXISTS "clan_members_select" ON clan_members;
DROP POLICY IF EXISTS "clan_members_insert_pending" ON clan_members;
DROP POLICY IF EXISTS "clan_members_insert_creator" ON clan_members;
DROP POLICY IF EXISTS "clan_members_update" ON clan_members;
DROP POLICY IF EXISTS "clan_members_delete" ON clan_members;

-- Policies on clans (001_initial_schema.sql + 005_parties.sql)
DROP POLICY IF EXISTS "Anyone can view clans" ON clans;
DROP POLICY IF EXISTS "Anyone can create clan" ON clans;
DROP POLICY IF EXISTS "Admin can update clan" ON clans;
DROP POLICY IF EXISTS "Public clans are viewable" ON clans;

-- Policies on users (001_initial_schema.sql)
DROP POLICY IF EXISTS "Users can view all users" ON users;
DROP POLICY IF EXISTS "Users can update own profile" ON users;
DROP POLICY IF EXISTS "Auth can insert user on signup" ON users;

-- =====================================================
-- DROP TRIGGERS
-- =====================================================
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- =====================================================
-- DROP FUNCTIONS
-- =====================================================
DROP FUNCTION IF EXISTS handle_new_user() CASCADE;
DROP FUNCTION IF EXISTS user_has_clan_role(UUID, UUID, TEXT[]) CASCADE;

-- =====================================================
-- DROP TABLES (order matters due to foreign keys)
-- =====================================================

-- 005_parties.sql tables
DROP TABLE IF EXISTS recruitment_applications CASCADE;
DROP TABLE IF EXISTS party_roster CASCADE;
DROP TABLE IF EXISTS parties CASCADE;

-- 003_events.sql tables
DROP TABLE IF EXISTS announcements CASCADE;
DROP TABLE IF EXISTS event_rsvps CASCADE;
DROP TABLE IF EXISTS events CASCADE;

-- 001_initial_schema.sql tables
DROP TABLE IF EXISTS member_professions CASCADE;
DROP TABLE IF EXISTS members CASCADE;
DROP TABLE IF EXISTS clan_members CASCADE;
DROP TABLE IF EXISTS clans CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- =====================================================
-- DROP TYPES (002_character_management.sql + 003_events.sql)
-- =====================================================
DROP TYPE IF EXISTS race CASCADE;
DROP TYPE IF EXISTS archetype CASCADE;
DROP TYPE IF EXISTS event_type CASCADE;
DROP TYPE IF EXISTS rsvp_status CASCADE;

-- =====================================================
-- OPTIONAL: Clear auth.users (commented out for safety)
-- =====================================================
-- DELETE FROM auth.users;

-- Confirm nuke complete
DO $$ BEGIN
  RAISE NOTICE '🔥 NUKE COMPLETE - All tables, functions, policies, and types dropped';
END $$;
