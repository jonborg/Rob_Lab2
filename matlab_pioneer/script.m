sp=serial_port_start;
pioneer_init(sp);
pause;
pioneer_set_controls(sp, 350, 0);
pioneer_read_odometry
pause;
pioneer_set_controls(sp, 0, 0);
serial_port_stop(sp);