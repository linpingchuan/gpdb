-- This file should be run when primary is in changetracking.  Number
-- of blocks changed should be greater than gp_filerep_ct_batch_size.
show gp_filerep_ct_batch_size;

-- Change blocks of resync_bug_table in a particular order such that a
-- higher numbered block has lower LSN.  Schema of resync_bug_table is
-- such that one block accommodates 901 tuples.  Leverage this to
-- identify a block.  Change Block 4 first so that it has lower LSN
-- than blocks 0, 1, 2.
delete from resync_bug_table where a = 1 and b = 901*5;
-- Block 0
delete from resync_bug_table where a = 1 and b = 901;
-- Block 1
delete from resync_bug_table where a = 1 and b = 901*2;
-- Block 2
delete from resync_bug_table where a = 1 and b = 901*3;
-- Block 3
delete from resync_bug_table where a = 1 and b = 901*4;

select * from resync_bug_table where a = 1 and
 b in (901, 901*2, 901*3, 901*4, 901*5);
