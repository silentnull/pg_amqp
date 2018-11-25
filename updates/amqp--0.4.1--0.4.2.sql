-- NOTE: No changes to sql extension code contained in this update. Only C code has been patched, so a "make install" must be run to apply the bug fix. You must also still run "ALTER EXTENSION pg_ampq UPDATE' to update the extension version number in the database. 

-- Clarify commit/rollback warning messages (Github Pull Request #15)

ALTER TABLE @extschema@.broker ADD COLUMN channel_max INTEGER NOT NULL DEFAULT 2048;
