resource r0 {
	meta-disk internal;
	device /dev/drbd0;
	disk /dev/loop7;
 
	syncer { rate 1000M; }
        net { 
                allow-two-primaries; 
                after-sb-0pri discard-zero-changes;
                after-sb-1pri discard-secondary;
                after-sb-2pri disconnect;
        }
	startup { become-primary-on both; }
 
	on server1 { address 0.0.0.0.:7789; }
	on server2 { address 1.1.1.1.:7789; }
}