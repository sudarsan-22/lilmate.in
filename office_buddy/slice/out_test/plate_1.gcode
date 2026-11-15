; HEADER_BLOCK_START
; BambuStudio 02.08.02.61
; model printing time: 12m 4s; total estimated time: 12m 23s
; total layer number: 73
; total filament length [mm] : 819.90
; total filament volume [cm^3] : 1972.08
; total filament weight [g] : 2.48
; model label id: 66,77,88
; object max height: 4.52,8.84,7.16
; filament_density: 1.26
; filament_diameter: 1.75
; max_z_height: 8.84
; filament: 1
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 70
; additional_fan_full_speed_layer = 0
; alternate_extra_wall = 0
; ams_filament_load_time_ams = 0
; ams_filament_load_time_ams_lite = 0
; ams_filament_load_time_n3f_s = 0
; ams_filament_unload_time_ams = 0
; ams_filament_unload_time_ams_lite = 0
; ams_filament_unload_time_n3f_s = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 0
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 
; bed_heat_soak_area = 
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.7,0.5
; bottom_color_penetration_layers = 5
; bottom_shell_layers = 5
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 30
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = M620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\n\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\n\n{if next_extruder < 255}\nM400\n\nG92 E0\n{if flush_length_1 > 1}\n; FLUSH_START\n; always use highest temperature to flush\nM400\nM109 S[nozzle_temperature_range_high]\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\nG1 X80 F15000\nG1 X60 F15000\nG1 X80 F15000\nG1 X60 F15000; shake to put down garbage\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_additional_fan_first_x_layers = 1
; close_fan_the_first_x_layers = 1
; compatible_machine_expression_group = ;;
; compatible_printers_condition = 
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 35
; cool_plate_temp_initial_layer = 35
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10
; cooling_slowdown_logic = uniform_cooling
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; counterbore_hole_bridging = none
; curr_bed_type = Cool Plate
; default_acceleration = 6000
; default_ams_type = -1
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL A1M"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL A1M
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50
; different_settings_to_system = ;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0
; enable_prime_tower = 1
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 0
; eng_plate_temp_initial_layer = 0
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 
; extruder_clearance_dist_to_rod = 56.5
; extruder_clearance_height_to_lid = 180
; extruder_clearance_height_to_rod = 25
; extruder_clearance_max_radius = 73
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = 
; extruder_offset = 0x0
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard"
; fan_cooling_layer_time = 80
; fan_direction = undefine
; fan_max_speed = 80
; fan_min_speed = 60
; farthest_point_timelapse = 0
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 100
; filament_bridge_speed = 25
; filament_change_length = 5
; filament_change_length_nc = 10
; filament_colour = #00AE42
; filament_cooling_before_tower = 0
; filament_cost = 19.99
; filament_density = 1.26
; filament_dev_ams_drying_ams_limitations = 1
; filament_dev_ams_drying_heat_distortion_temperature = 45
; filament_dev_ams_drying_temperature = 45
; filament_dev_ams_drying_time = 12
; filament_dev_chamber_drying_bed_temperature = 70
; filament_dev_chamber_drying_time = 12
; filament_dev_drying_cooling_temperature = 45
; filament_dev_drying_softening_temperature = 50
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.98
; filament_flush_temp = 0
; filament_flush_temp_fast = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFA00
; filament_is_mixed = 0
; filament_is_support = 0
; filament_long_retractions_when_cut = 1
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 21
; filament_metal_stickiness = None
; filament_minimal_purge_on_wipe_tower = 15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_notes = 
; filament_nozzle_map = 0
; filament_overhang_1_4_speed = 0
; filament_overhang_2_4_speed = 50
; filament_overhang_3_4_speed = 30
; filament_overhang_4_4_speed = 10
; filament_overhang_totally_speed = 10
; filament_pre_cooling_temperature = 0
; filament_pre_cooling_temperature_nc = 0
; filament_preheat_temperature_delta = 0
; filament_prime_volume = 30
; filament_prime_volume_nc = 60
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_travel_time_nc = 0
; filament_ramming_volumetric_speed = -1
; filament_ramming_volumetric_speed_nc = -1
; filament_retract_length_nc = 14
; filament_retraction_distances_when_cut = 18
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "Bambu PLA Basic @BBL A1M (pengu)"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = PLA
; filament_velocity_adaptation_factor = 1
; filament_vendor = "Bambu Lab"
; filament_volume_map = 0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0
; first_x_layer_part_fan_speed = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_multiplier_fast = 1.2
; flush_volumes_matrix = 0,280,280,280,280,0,280,280,280,280,0,280,280,280,280,0
; flush_volumes_vector = 140,140,140,140,140,140,140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 350
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 17.4
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 156x152,180x152,180x180,156x180
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; hot_plate_temp = 60
; hot_plate_temp_initial_layer = 60
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 13.8
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = ;"Bambu PLA Basic @BBL A1M";"Bambu Lab A1 mini 0.4 nozzle"
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 350
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 350
; ironing_direction = 45
; ironing_fan_speed = -1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.12
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
; machine_bed_mass_Y = 0
; machine_end_gcode = ;===== date: 20230428 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos \nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of \"timelapse_record_flag\"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nG90\nG1 X128 Y250 F3600\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 28
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 6000,6000
; machine_max_acceleration_x = 6000,6000
; machine_max_acceleration_y = 6000,6000
; machine_max_acceleration_z = 1500,1500
; machine_max_force_Y = 0
; machine_max_jerk_e = 3,3
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 5,5
; machine_max_printed_mass = 0
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 30,30
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = G0 Z20 F9000\nG92 E0; G1 E-10 F1200\nG28\nM970 Q1 A10 B10 C130 K0\nM970 Q1 A10 B131 C250 K1\nM974 Q1 S1 P0\nM970 Q0 A10 B10 C130 H20 K0\nM970 Q0 A10 B131 C250 K1\nM974 Q0 S1 P0\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nG29 ;Home\nG90;\nG92 E0 ;Reset Extruder \nG1 Z2.0 F3000 ;Move Z Axis up \nG1 X10.1 Y20 Z0.28 F5000.0 ;Move to start position\nM109 S205;\nG1 X10.1 Y200.0 Z0.28 F1500.0 E15 ;Draw the first line\nG1 X10.4 Y200.0 Z0.28 F5000.0 ;Move to side a little\nG1 X10.4 Y20 Z0.28 F1500.0 E30 ;Draw the second line\nG92 E0 ;Reset Extruder \nG1 X110 Y110 Z2.0 F3000 ;Move Z Axis up
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 34
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 0%
; no_slow_down_for_cooling_on_outwalls = 0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.76
; nozzle_temperature = 220
; nozzle_temperature_initial_layer = 220
; nozzle_temperature_range_high = 240
; nozzle_temperature_range_low = 190
; nozzle_type = stainless_steel
; nozzle_volume = 92
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 60
; overhang_2_4_speed = 30
; overhang_3_4_speed = 10
; overhang_4_4_speed = 10
; overhang_fan_speed = 100
; overhang_fan_threshold = 50%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 2
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab A1 mini 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_in_clockwise = 0
; print_sequence = by layer
; print_settings_id = 0.12mm Fine (lilmate retro pc)
; printable_area = 0x0,180x0,180x180,0x180
; printable_height = 180
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab A1 mini
; printer_notes = 
; printer_settings_id = Bambu Lab A1 mini 0.4 nozzle
; printer_structure = i3
; printer_technology = FFF
; printer_variant = 0.4
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 179
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = back
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; skirt_per_object = 1
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 6
; slow_down_min_speed = 20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 80
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = gyroid
; sparse_infill_speed = 430
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 45
; supertack_plate_temp_initial_layer = 45
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.12
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_fast_purge_mode = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 20
; support_top_z_distance = 0.12
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45
; template_custom_gcode = 
; textured_plate_temp = 65
; textured_plate_temp_initial_layer = 65
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;========Date 20250206========\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400 P300\nM971 S11 C10 O0\nG92 E0\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 6
; top_shell_thickness = 0.6
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 700
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle";"Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab X2D 0.4 nozzle";"Bambu Lab A2L 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 3
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 15
; wipe_tower_y = 220
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R12
M201 X6000 Y6000 Z1500 E5000
M203 X500 Y500 Z30 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z5.00 E3.00
M106 S0
M190 S35 ; set bed temperature and wait for it to be reached
; FEATURE: Custom
G0 Z20 F9000
G92 E0; G1 E-10 F1200
G28
M970 Q1 A10 B10 C130 K0
M970 Q1 A10 B131 C250 K1
M974 Q1 S1 P0
M970 Q0 A10 B10 C130 H20 K0
M970 Q0 A10 B131 C250 K1
M974 Q0 S1 P0
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
G29 ;Home
G90;
G92 E0 ;Reset Extruder 
G1 Z2.0 F3000 ;Move Z Axis up 
G1 X10.1 Y20 Z0.28 F5000.0 ;Move to start position
M109 S205;
G1 X10.1 Y200.0 Z0.28 F1500.0 E15 ;Draw the first line
G1 X10.4 Y200.0 Z0.28 F5000.0 ;Move to side a little
G1 X10.4 Y20 Z0.28 F1500.0 E30 ;Draw the second line
G92 E0 ;Reset Extruder 
M73 P1 R12
G1 X110 Y110 Z2.0 F3000 ;Move Z Axis up
; MACHINE_START_GCODE_END
; filament start gcode


;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/73
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M73 P2 R12
G1 X86.597 Y105.958 F42000
M204 S6000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X86.52 Y105.88 E.00408
G3 X85.486 Y103.421 I2.497 J-2.497 E.10188
G1 X85.486 Y93.879 E.35544
G3 X88.979 Y90.386 I3.531 J.038 E.20374
G1 X98.521 Y90.386 E.35544
G3 X102.014 Y93.879 I-.038 J3.531 E.20374
G1 X102.014 Y103.421 E.35544
G3 X98.521 Y106.914 I-3.531 J-.038 E.20374
G1 X88.979 Y106.914 E.35544
G3 X86.865 Y106.183 I.038 J-3.531 E.08477
G1 X86.643 Y105.996 E.01079
M204 S6000
G1 X86.898 Y105.615 F42000
G1 F3000
M204 S500
G1 X86.843 Y105.557 E.00297
G3 X85.943 Y103.414 I2.172 J-2.172 E.08879
G1 X85.943 Y93.886 E.35489
G3 X88.986 Y90.843 I3.072 J.029 E.17758
G1 X98.514 Y90.843 E.35489
G3 X101.557 Y93.886 I-.029 J3.072 E.17758
G1 X101.557 Y103.414 E.35489
G3 X98.514 Y106.457 I-3.072 J-.029 E.17758
G1 X88.986 Y106.457 E.35489
G3 X87.143 Y105.821 I.029 J-3.072 E.07391
G1 X86.944 Y105.653 E.00967
M204 S6000
G1 X87.196 Y105.267 F42000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X87.165 Y105.235 E.00165
G3 X86.4 Y103.407 I1.848 J-1.848 E.07571
G1 X86.4 Y93.893 E.35434
G3 X88.993 Y91.3 I2.613 J.02 E.15141
G1 X98.507 Y91.3 E.35434
G3 X101.1 Y93.893 I-.02 J2.613 E.15141
G1 X101.1 Y103.407 E.35434
G3 X98.507 Y106 I-2.613 J-.02 E.15141
M73 P3 R12
G1 X88.993 Y106 E.35434
G3 X87.558 Y105.558 I.02 J-2.613 E.05673
G1 X87.243 Y105.304 E.01507
; WIPE_START
G1 X87.165 Y105.235 E-.03956
G1 X86.838 Y104.845 E-.19351
G1 X86.598 Y104.395 E-.19365
G1 X86.45 Y103.907 E-.19372
G1 X86.413 Y103.542 E-.13955
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X83.771 Y108.336 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G3 X83.064 Y107.629 I-.015 J-.692 E.04163
G1 X83.064 Y89.671 E.66884
G3 X83.771 Y88.964 I.692 J-.015 E.04163
G1 X84.726 Y88.964 E.03555
G1 X103.736 Y88.964 E.70805
G3 X104.436 Y89.671 I.009 J.692 E.04136
G1 X104.436 Y107.629 E.66884
M73 P3 R11
G3 X103.729 Y108.336 I-.692 J.015 E.04163
G1 X83.831 Y108.336 E.74109
M204 S6000
G1 X83.764 Y108.793 F42000
G1 F3000
M204 S500
G3 X82.607 Y107.636 I-.006 J-1.151 E.06779
G1 X82.607 Y89.664 E.66939
G3 X83.764 Y88.507 I1.151 J-.006 E.06779
G1 X84.726 Y88.507 E.03583
G1 X103.743 Y88.507 E.70832
G3 X104.893 Y89.664 I-.001 J1.15 E.06752
G1 X104.893 Y107.636 E.66939
G3 X103.736 Y108.793 I-1.151 J.006 E.06779
G1 X83.824 Y108.793 E.74165
M204 S6000
G1 X83.757 Y109.25 F42000
; FEATURE: Outer wall
G1 F3000
M204 S500
G3 X82.15 Y107.643 I.003 J-1.61 E.09395
G1 X82.15 Y89.657 E.66994
G3 X83.757 Y88.05 I1.61 J.003 E.09395
G1 X84.726 Y88.05 E.0361
G1 X103.751 Y88.05 E.7086
G3 X105.35 Y89.657 I-.01 J1.609 E.09368
G1 X105.35 Y107.643 E.66994
G3 X103.743 Y109.25 I-1.61 J-.003 E.09395
G1 X83.817 Y109.25 E.7422
; WIPE_START
G1 X83.438 Y109.219 E-.1444
G1 X83.138 Y109.128 E-.11921
G1 X82.861 Y108.98 E-.11915
G1 X82.619 Y108.782 E-.11893
G1 X82.42 Y108.539 E-.11918
G1 X82.272 Y108.262 E-.1194
G1 X82.257 Y108.212 E-.01973
; WIPE_END
G1 E-.04 F1800
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 1 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer1 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X104.253 Y90.382
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5006
G1 F6300
M204 S500
G1 X103.223 Y89.353 E.0543
G1 X102.576 Y89.353 E.02414
G1 X104.047 Y90.824 E.07759
G1 X104.047 Y91.471 E.02414
G1 X101.929 Y89.353 E.11173
G1 X101.282 Y89.353 E.02414
G1 X104.047 Y92.119 E.14587
G1 X104.047 Y92.766 E.02414
G1 X100.634 Y89.353 E.18001
G1 X99.987 Y89.353 E.02414
G1 X104.047 Y93.413 E.21415
M73 P4 R11
G1 X104.047 Y94.06 E.02414
G1 X99.34 Y89.353 E.24829
G1 X98.693 Y89.353 E.02414
G1 X99.458 Y90.118 E.04038
G2 X98.701 Y90.009 I-.801 J2.856 E.02862
G1 X98.045 Y89.353 E.03458
G1 X97.398 Y89.353 E.02414
G1 X98.043 Y89.997 E.03399
G1 X97.395 Y89.997 E.02414
G1 X96.751 Y89.353 E.03399
G1 X96.104 Y89.353 E.02414
G1 X96.748 Y89.997 E.034
G1 X96.101 Y89.997 E.02414
G1 X95.456 Y89.353 E.034
G1 X94.809 Y89.353 E.02414
G1 X95.454 Y89.997 E.034
G1 X94.806 Y89.997 E.02414
G1 X94.162 Y89.353 E.034
G1 X93.514 Y89.353 E.02414
G1 X94.159 Y89.997 E.034
G1 X93.512 Y89.997 E.02414
G1 X92.867 Y89.353 E.034
G1 X92.22 Y89.353 E.02414
G1 X92.865 Y89.997 E.034
G1 X92.217 Y89.997 E.02414
G1 X91.573 Y89.353 E.034
G1 X90.925 Y89.353 E.02414
G1 X91.57 Y89.997 E.034
G1 X90.923 Y89.997 E.02414
G1 X90.278 Y89.353 E.034
G1 X89.631 Y89.353 E.02414
G1 X90.276 Y89.997 E.034
G1 X89.628 Y89.997 E.02414
G1 X88.984 Y89.353 E.034
G1 X88.336 Y89.353 E.02414
G1 X88.981 Y89.997 E.034
G2 X88.384 Y90.047 I.404 J8.401 E.02235
G1 X87.689 Y89.353 E.03664
G1 X87.042 Y89.353 E.02414
G1 X87.861 Y90.172 E.04321
G2 X87.391 Y90.349 I.735 J2.655 E.01875
G1 X86.395 Y89.353 E.05257
G1 X85.747 Y89.353 E.02414
G1 X86.965 Y90.571 E.06425
G2 X86.588 Y90.84 I1.179 J2.052 E.01733
G1 X85.1 Y89.353 E.07847
G2 X84.453 Y89.353 I-.187 J154.945 E.02412
G1 X86.245 Y91.145 E.09451
G2 X85.936 Y91.483 I1.562 J1.738 E.01711
G1 X83.807 Y89.355 E.11228
G2 X83.455 Y89.649 I-.041 J.309 E.01927
G1 X85.673 Y91.867 E.11698
G2 X85.45 Y92.291 I1.494 J1.056 E.01793
G1 X83.455 Y90.296 E.10521
G1 X83.455 Y90.944 E.02414
G1 X85.272 Y92.761 E.09587
G2 X85.147 Y93.284 I3.065 J1.009 E.02005
G1 X83.455 Y91.591 E.08929
G1 X83.455 Y92.238 E.02414
G1 X85.097 Y93.881 E.08665
G1 X85.098 Y94.528 E.02416
G1 X83.454 Y92.885 E.08668
G1 X83.454 Y93.532 E.02414
G1 X85.098 Y95.176 E.08671
G1 X85.099 Y95.824 E.02416
G1 X83.454 Y94.179 E.08673
G1 X83.454 Y94.827 E.02414
G1 X85.099 Y96.472 E.08676
G1 X85.1 Y97.119 E.02416
G1 X83.454 Y95.474 E.08679
G1 X83.454 Y96.121 E.02414
G1 X85.1 Y97.767 E.08682
G1 X85.101 Y98.415 E.02416
G1 X83.454 Y96.768 E.08685
G1 X83.454 Y97.415 E.02414
G1 X85.101 Y99.062 E.08687
G1 X85.101 Y99.71 E.02416
G1 X83.454 Y98.063 E.0869
G1 X83.454 Y98.71 E.02414
G1 X85.102 Y100.358 E.08693
G1 X85.102 Y101.006 E.02416
G1 X83.454 Y99.357 E.08696
G1 X83.454 Y100.004 E.02414
G1 X85.103 Y101.653 E.08699
G1 X85.103 Y102.301 E.02416
G1 X83.453 Y100.651 E.08701
G1 X83.453 Y101.298 E.02414
G1 X85.104 Y102.949 E.08704
G1 X85.104 Y103.596 E.02416
G1 X83.453 Y101.946 E.08707
G1 X83.453 Y102.593 E.02414
G1 X85.533 Y104.672 E.10969
; WIPE_START
G1 X84.119 Y103.258 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X90.677 Y99.354 Z.6 F42000
G1 X101.972 Y92.632 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X104.047 Y94.708 E.10948
G1 X104.047 Y95.355 E.02414
G1 X102.396 Y93.703 E.08711
G1 X102.396 Y94.351 E.02414
G1 X104.047 Y96.002 E.08711
G1 X104.047 Y96.649 E.02414
G1 X102.396 Y94.998 E.08711
G1 X102.396 Y95.645 E.02414
G1 X104.047 Y97.297 E.08711
G1 X104.047 Y97.944 E.02414
M73 P5 R11
G1 X102.396 Y96.292 E.08711
G1 X102.396 Y96.94 E.02414
G1 X104.047 Y98.591 E.08711
G1 X104.047 Y99.238 E.02414
G1 X102.396 Y97.587 E.08711
G1 X102.396 Y98.234 E.02414
G1 X104.047 Y99.886 E.08711
G1 X104.047 Y100.533 E.02414
G1 X102.396 Y98.881 E.08711
G1 X102.396 Y99.529 E.02414
G1 X104.047 Y101.18 E.08711
G1 X104.047 Y101.827 E.02414
G1 X102.396 Y100.176 E.08711
G1 X102.396 Y100.823 E.02414
G1 X104.047 Y102.475 E.08711
G1 X104.047 Y103.122 E.02414
G1 X102.396 Y101.47 E.08711
G1 X102.396 Y102.118 E.02414
G1 X104.047 Y103.769 E.08711
G1 X104.047 Y104.416 E.02414
G1 X102.396 Y102.765 E.08711
G1 X102.396 Y103.412 E.02414
G1 X104.047 Y105.064 E.08711
G1 X104.047 Y105.711 E.02414
G1 X102.35 Y104.014 E.08952
G3 X102.228 Y104.539 I-2.053 J-.202 E.02016
G1 X104.047 Y106.358 E.09598
G1 X104.047 Y107.005 E.02414
G1 X102.051 Y105.009 E.10532
G3 X101.827 Y105.433 I-1.722 J-.636 E.01792
G1 X104.044 Y107.649 E.11691
G3 X103.695 Y107.947 I-.307 J-.007 E.01933
G1 X101.564 Y105.817 E.11239
G3 X101.255 Y106.155 I-1.872 J-1.401 E.01711
G1 X103.047 Y107.947 E.09455
G1 X102.4 Y107.947 E.02414
G1 X100.917 Y106.464 E.07825
G3 X100.533 Y106.727 I-1.527 J-1.814 E.01739
G1 X101.753 Y107.947 E.06436
G1 X101.106 Y107.947 E.02414
G1 X100.109 Y106.95 E.05258
G3 X99.639 Y107.128 I-.906 J-1.691 E.01879
G1 X100.458 Y107.947 E.04323
G1 X99.811 Y107.947 E.02414
G1 X99.113 Y107.249 E.03684
G3 X98.512 Y107.296 I-.479 J-2.256 E.02252
G1 X99.164 Y107.947 E.03436
G1 X98.517 Y107.947 E.02414
G1 X97.865 Y107.296 E.03436
G1 X97.218 Y107.296 E.02414
G1 X97.869 Y107.947 E.03436
G1 X97.222 Y107.947 E.02414
G1 X96.571 Y107.296 E.03436
G1 X95.923 Y107.296 E.02414
G1 X96.575 Y107.947 E.03436
G1 X95.928 Y107.947 E.02414
G1 X95.276 Y107.296 E.03436
G1 X94.629 Y107.296 E.02414
G1 X95.28 Y107.947 E.03436
G1 X94.633 Y107.947 E.02414
G1 X93.982 Y107.296 E.03436
G1 X93.334 Y107.296 E.02414
G1 X93.986 Y107.947 E.03436
G1 X93.339 Y107.947 E.02414
G1 X92.687 Y107.296 E.03436
G1 X92.04 Y107.296 E.02414
G1 X92.691 Y107.947 E.03436
G1 X92.044 Y107.947 E.02414
G1 X91.393 Y107.296 E.03436
G1 X90.745 Y107.296 E.02414
G1 X91.397 Y107.947 E.03436
G1 X90.75 Y107.947 E.02414
G1 X90.098 Y107.296 E.03436
G1 X89.451 Y107.296 E.02414
G1 X90.102 Y107.947 E.03436
G1 X89.455 Y107.947 E.02414
G1 X88.804 Y107.296 E.03436
G1 X88.745 Y107.296 E.00219
G3 X88.044 Y107.183 I.222 J-3.617 E.02653
G1 X88.808 Y107.947 E.04031
G1 X88.161 Y107.947 E.02414
G1 X83.453 Y103.24 E.24828
G1 X83.453 Y103.887 E.02414
G1 X87.513 Y107.947 E.21415
G1 X86.866 Y107.947 E.02414
G1 X83.453 Y104.534 E.18001
G1 X83.453 Y105.182 E.02414
G1 X86.219 Y107.947 E.14588
G1 X85.572 Y107.947 E.02414
G1 X83.453 Y105.829 E.11174
G1 X83.453 Y106.476 E.02414
G1 X84.924 Y107.947 E.07761
G1 X84.277 Y107.947 E.02414
G1 X83.247 Y106.917 E.05432
; OBJECT_ID: 66
; WIPE_START
G1 X84.277 Y107.947 E-.5535
G1 X84.82 Y107.947 E-.20651
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S6000
G1 X89.636 Y102.026 Z.6 F42000
G1 X104.285 Y84.013 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X104.143 Y84.041 E.00538
G2 X104.207 Y82.345 I-14.878 J-1.409 E.06326
G1 X104.207 Y75.582 E.25191
G2 X104.151 Y74.03 I-13.468 J-.29 E.05785
G1 X104.069 Y73.636 E.015
G1 X104.74 Y73.696 E.02509
G1 X104.893 Y73.699 E.00569
G1 X104.893 Y83.893 E.3797
G1 X104.344 Y84.002 E.02085
; WIPE_START
G1 X104.143 Y84.041 E-.07768
M73 P6 R11
G1 X104.199 Y83.344 E-.26574
G1 X104.207 Y82.345 E-.37976
G1 X104.207 Y82.248 E-.03682
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X104.532 Y85.261 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X104.479 Y84.441 E.03059
G1 X103.725 Y84.59 E.02862
G1 X103.604 Y84.59 E.00453
G1 X103.61 Y84.304 E.01067
G2 X103.75 Y82.83 I-6.267 J-1.337 E.05526
G1 X103.75 Y75.582 E.26995
G2 X103.698 Y74.097 I-13.025 J-.288 E.05538
G1 X103.553 Y73.4 E.02651
G1 X95.4 Y73.4 E.30369
G1 X95.4 Y73.49 E.00335
G1 X92.424 Y73.49 E.11086
G2 X92.434 Y73.1 I-.75 J-.215 E.01469
G1 X103.783 Y73.1 E.4227
G1 X104.257 Y73.194 E.01803
G2 X105.35 Y73.249 I1.082 J-10.596 E.04077
G1 X105.35 Y85.251 E.44701
G2 X104.592 Y85.259 I-.044 J29.986 E.02825
; WIPE_START
G1 X104.479 Y84.441 E-.31383
G1 X103.725 Y84.59 E-.29199
G1 X103.604 Y84.59 E-.04625
G1 X103.61 Y84.306 E-.10794
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X95.986 Y84.655 Z.6 F42000
G1 X91.431 Y84.864 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G2 X90.607 Y84.801 I-.863 J5.885 E.03079
G1 X90.607 Y74.607 E.3797
G1 X91.357 Y74.459 E.02846
G1 X91.301 Y75.156 E.02605
G2 X91.293 Y76.155 I36.622 J.791 E.03722
G1 X91.293 Y82.918 E.25191
G2 X91.349 Y84.47 I13.468 J.29 E.05785
G1 X91.419 Y84.805 E.01277
; WIPE_START
G1 X90.607 Y84.801 E-.30839
G1 X90.607 Y83.613 E-.45161
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X98.162 Y84.696 Z.6 F42000
G1 X103.066 Y85.4 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X91.717 Y85.4 E.4227
G2 X90.15 Y85.251 I-1.294 J5.288 E.05885
G1 X90.15 Y73.249 E.44701
G2 X90.968 Y73.239 I.044 J-29.986 E.03049
G1 X90.968 Y73.26 E.00075
G1 X91.021 Y74.059 E.02984
G1 X91.775 Y73.91 E.02862
G1 X91.896 Y73.91 E.00453
G1 X91.89 Y74.196 E.01067
G2 X91.75 Y75.67 I6.267 J1.337 E.05526
G1 X91.75 Y82.918 E.26995
G2 X91.802 Y84.403 I13.025 J.288 E.05538
G1 X91.947 Y85.1 E.02651
G1 X100.1 Y85.1 E.30369
G1 X100.1 Y85.01 E.00335
G1 X103.076 Y85.01 E.11086
G2 X103.055 Y85.341 I.75 J.215 E.01245
; WIPE_START
G1 X101.055 Y85.351 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X104.934 Y85.025 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.446193
G1 F3000
M204 S500
G1 X104.905 Y84.124 E.02962
M204 S6000
G1 X104.531 Y83.732 F42000
; LINE_WIDTH: 0.273402
G1 F3000
M204 S500
G1 X104.55 Y82.835 E.01686
G1 X104.546 Y74.567 E.15528
; LINE_WIDTH: 0.30262
G1 X104.517 Y73.906 E.014
; WIPE_START
G1 X104.546 Y74.567 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X96.936 Y73.972 Z.6 F42000
G1 X90.566 Y73.475 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.446193
G1 F3000
M204 S500
G1 X90.595 Y74.376 E.02962
M204 S6000
G1 X90.969 Y74.768 F42000
; LINE_WIDTH: 0.273196
G1 F3000
M204 S500
G1 X90.95 Y75.665 E.01684
G1 X90.955 Y83.942 E.1553
; LINE_WIDTH: 0.302901
G1 X90.983 Y84.594 E.01384
; OBJECT_ID: 88
; WIPE_START
G1 X90.955 Y83.942 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S6000
G1 X85.529 Y84.336 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X76.471 Y84.336 E.33734
G3 X75.564 Y83.429 I-.015 J-.892 E.05333
G1 X75.564 Y72.571 E.40439
G3 X76.471 Y71.664 I.892 J-.015 E.05333
G1 X85.595 Y71.666 E.3398
G3 X86.436 Y72.571 I-.046 J.886 E.05091
G1 X86.436 Y83.429 E.40439
G3 X85.589 Y84.335 I-.892 J.015 E.05109
M204 S6000
G1 X85.539 Y84.793 F42000
G1 F3000
M204 S500
G1 X85.536 Y84.793 E.0001
G1 X76.464 Y84.793 E.3379
G3 X75.107 Y83.436 I-.006 J-1.351 E.07949
G1 X75.107 Y72.564 E.40494
G3 X76.464 Y71.207 I1.351 J-.006 E.07949
G1 X85.623 Y71.21 E.34114
G3 X86.893 Y72.564 I-.075 J1.343 E.07632
M73 P7 R11
G1 X86.893 Y83.436 E.40494
G3 X85.812 Y84.766 I-1.351 J.006 E.06915
G1 X85.598 Y84.787 E.00798
M204 S6000
G1 X85.583 Y85.246 F42000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X85.543 Y85.25 E.00147
G1 X76.457 Y85.25 E.33845
G3 X74.65 Y83.443 I.003 J-1.81 E.10564
G1 X74.65 Y72.557 E.40549
G3 X76.457 Y70.75 I1.81 J.003 E.10565
G1 X85.651 Y70.754 E.34247
G3 X87.35 Y72.557 I-.103 J1.799 E.10173
G1 X87.35 Y83.443 E.40549
G3 X85.901 Y85.214 I-1.81 J-.003 E.09225
G1 X85.642 Y85.24 E.00968
; WIPE_START
G1 X85.543 Y85.25 E-.03776
G1 X83.643 Y85.25 E-.72225
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X84.356 Y77.651 Z.6 F42000
G1 X84.901 Y71.849 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50127
G1 F6300
M204 S500
G1 X86.045 Y72.993 E.06041
G1 X86.045 Y73.641 E.02422
G1 X84.459 Y72.055 E.08379
G1 X83.811 Y72.055 E.02421
G1 X86.045 Y74.29 E.11804
G1 X86.045 Y74.938 E.02422
G1 X83.162 Y72.055 E.15228
G1 X82.514 Y72.055 E.02421
G1 X86.046 Y75.586 E.18653
G1 X86.046 Y76.235 E.02422
G1 X81.866 Y72.055 E.22077
G1 X81.218 Y72.055 E.02421
G1 X86.046 Y76.883 E.25502
G1 X86.046 Y77.531 E.02422
G1 X80.57 Y72.055 E.28926
G1 X79.921 Y72.055 E.02421
G1 X86.046 Y78.18 E.32351
G1 X86.046 Y78.828 E.02422
G1 X79.273 Y72.055 E.35775
G1 X78.625 Y72.055 E.02421
G1 X86.046 Y79.476 E.392
G1 X86.047 Y80.125 E.02422
G1 X77.977 Y72.055 E.42625
G1 X77.329 Y72.055 E.02421
G1 X86.047 Y80.773 E.46049
G1 X86.047 Y81.421 E.02422
G1 X76.681 Y72.055 E.49474
G2 X76.143 Y72.166 I-.126 J.75 E.02098
G1 X86.047 Y82.07 E.52315
G1 X86.047 Y82.718 E.02422
G1 X75.953 Y72.624 E.5332
G1 X75.953 Y73.272 E.02421
G1 X86.047 Y83.367 E.53321
G3 X85.862 Y83.83 I-.553 J.047 E.01931
G1 X75.953 Y73.92 E.52342
G1 X75.953 Y74.568 E.02421
G1 X85.332 Y83.947 E.49541
G1 X84.684 Y83.947 E.02421
G1 X75.953 Y75.216 E.46117
G1 X75.953 Y75.865 E.02421
G1 X84.035 Y83.947 E.42693
M73 P8 R11
G1 X83.387 Y83.947 E.02421
G1 X75.953 Y76.513 E.39269
G1 X75.953 Y77.161 E.02421
G1 X82.739 Y83.947 E.35846
G1 X82.091 Y83.947 E.02421
G1 X75.953 Y77.809 E.32422
G1 X75.953 Y78.457 E.02421
G1 X81.443 Y83.947 E.28998
G1 X80.794 Y83.947 E.02421
G1 X75.953 Y79.106 E.25574
G1 X75.953 Y79.754 E.02421
G1 X80.146 Y83.947 E.2215
G1 X79.498 Y83.947 E.02421
G1 X75.953 Y80.402 E.18726
G1 X75.953 Y81.05 E.02421
G1 X78.85 Y83.947 E.15302
G1 X78.202 Y83.947 E.02421
G1 X75.953 Y81.699 E.11879
G1 X75.953 Y82.347 E.02421
G1 X77.553 Y83.947 E.08455
G1 X76.905 Y83.947 E.02421
G1 X75.953 Y82.995 E.05031
G2 X75.965 Y83.541 I3.004 J.208 E.02044
G2 X76.052 Y83.743 I.475 J-.087 E.00826
G1 X76.462 Y84.152 E.02164
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6300
G1 X76.052 Y83.743 E-.22013
G1 X75.965 Y83.541 E-.08333
G1 X75.953 Y82.995 E-.20772
G1 X76.416 Y83.458 E-.24882
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 2/73
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S201.45
; open powerlost recovery
M1003 S1
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I-1.104 J.512 P1  F42000
G1 X86.765 Y105.749 Z.6
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20428
M204 S6000
G1 X86.711 Y105.689 E.00168
G3 X85.757 Y103.417 I2.305 J-2.305 E.05242
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.259 J.033 E.10482
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.033 J3.259 E.10483
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X86.865 Y105.834 I.033 J-3.259 E.04802
G1 X86.811 Y105.788 E.00148
M204 S10000
G1 X87.059 Y105.437 F42000
G1 F20428
M204 S6000
G1 X87.011 Y105.39 E.00141
G3 X86.181 Y103.41 I2.003 J-2.004 E.04566
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.435 Y105.738 I.024 J-2.833 E.03425
G1 X87.106 Y105.475 E.00873
M204 S250
G1 X87.318 Y105.122 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.299 Y105.101 E.00055
G3 X86.59 Y103.404 I1.713 J-1.713 E.03637
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.663 Y105.399 I.016 J-2.422 E.02728
G1 X87.365 Y105.16 E.00738
; WIPE_START
M204 S6000
G1 X87.299 Y105.101 E-.03351
G1 X86.996 Y104.739 E-.17935
G1 X86.773 Y104.322 E-.17957
G1 X86.636 Y103.87 E-.17951
G1 X86.59 Y103.404 E-.1782
G1 X86.59 Y103.378 E-.00987
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z.72 F42000
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20428
M204 S6000
G3 X82.793 Y107.633 I-.009 J-.965 E.03181
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.965 J-.009 E.0318
G1 X103.752 Y88.694 E.41453
G3 X104.707 Y89.667 I-.009 J.964 E.03141
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.965 J.009 E.0318
G1 X83.827 Y108.607 E.41289
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F20428
M204 S6000
G3 X82.369 Y107.64 I0 J-1.391 E.04532
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.391 J0 E.04532
G1 X103.759 Y88.27 E.41482
G3 X105.131 Y89.66 I-.018 J1.39 E.04492
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.391 J0 E.04532
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.75 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X83.401 Y109.404 E.00676
G3 X81.96 Y107.647 I.361 J-1.765 E.04739
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.802 J.008 E.05423
G1 X103.765 Y87.861 E.38575
G3 X105.54 Y89.653 I-.026 J1.801 E.05387
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.802 J-.008 E.05423
G1 X83.81 Y109.44 E.38429
; WIPE_START
M204 S6000
G1 X83.401 Y109.404 E-.15602
G1 X83.065 Y109.304 E-.13319
G1 X82.756 Y109.139 E-.13299
G1 X82.485 Y108.916 E-.13336
G1 X82.262 Y108.644 E-.13365
G1 X82.174 Y108.48 E-.07078
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.72 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 2 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer2 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.711 Y106.531
G1 Z.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.497012
G1 F20428
M204 S6000
G2 X102.71 Y106.633 I-.029 J.051 E.00564
M204 S10000
G1 X103.114 Y104.83 F42000
; LINE_WIDTH: 0.419992
G1 F20428
M204 S6000
G1 X102.931 Y105.333 E.01031
G3 X101.707 Y107.015 I-4.518 J-2.002 E.04039
G1 X103.114 Y107.015 E.02712
G1 X103.114 Y104.89 E.04094
M204 S10000
G1 X102.98 Y103.622 F42000
; LINE_WIDTH: 0.525602
G1 F20428
M204 S6000
G1 X102.933 Y104.045 E.01038
; LINE_WIDTH: 0.557662
G1 F19740.182
G1 X102.887 Y104.467 E.01105
; LINE_WIDTH: 0.55448
G1 F19859.002
G1 X102.822 Y104.61 E.00407
; LINE_WIDTH: 0.516055
G1 F20428
G1 X102.757 Y104.753 E.00377
; LINE_WIDTH: 0.47763
G1 X102.692 Y104.897 E.00348
; LINE_WIDTH: 0.420333
G3 X102.379 Y105.561 I-20.023 J-9.02 E.01417
G3 X101.796 Y106.376 I-7.298 J-4.607 E.01935
G1 X101.356 Y106.797 E.01173
G1 X100.806 Y107.192 E.01307
G1 X100.375 Y107.409 E.00931
G1 X103.509 Y107.409 E.06046
G1 X103.508 Y105.185 E.0429
; LINE_WIDTH: 0.439355
G1 X103.489 Y105.02 E.00336
; LINE_WIDTH: 0.47808
G1 X103.47 Y104.856 E.00367
; LINE_WIDTH: 0.516805
G1 X103.45 Y104.691 E.00399
; LINE_WIDTH: 0.548216
G1 F20097.08
G1 X103.431 Y104.526 E.00424
G1 X103.459 Y103.83 E.01779
; LINE_WIDTH: 0.510286
G1 F20428
G1 X103.462 Y93.674 E.24059
G1 X103.445 Y93.055 E.01466
; LINE_WIDTH: 0.523234
G1 X103.465 Y92.756 E.0073
; LINE_WIDTH: 0.481937
G1 X103.486 Y92.457 E.00669
; LINE_WIDTH: 0.420687
G1 X103.507 Y92.158 E.00579
G1 X103.506 Y89.892 E.04375
G1 X100.376 Y89.892 E.06044
G1 X100.776 Y90.087 E.00859
G1 X101.274 Y90.436 E.01174
G1 X101.769 Y90.898 E.01308
G1 X102.297 Y91.601 E.01697
G1 X102.576 Y92.139 E.01172
; LINE_WIDTH: 0.43409
G1 X102.718 Y92.535 E.00839
; LINE_WIDTH: 0.462285
G1 X102.86 Y92.931 E.00897
; LINE_WIDTH: 0.493257
G1 X102.894 Y93.01 E.00197
; LINE_WIDTH: 0.510311
G1 X102.929 Y93.089 E.00205
G1 X102.979 Y93.674 E.01391
G1 X102.98 Y103.562 E.23427
M204 S10000
G1 X103.112 Y92.502 F42000
; LINE_WIDTH: 0.419992
G1 F20428
M204 S6000
G1 X103.112 Y90.286 E.04272
G1 X101.692 Y90.286 E.02738
G1 X102.217 Y90.814 E.01436
G3 X102.93 Y91.965 I-3.815 J3.158 E.02618
G1 X103.093 Y92.445 E.00977
M204 S10000
G1 X102.71 Y90.667 F42000
; LINE_WIDTH: 0.495452
G1 F20428
M204 S6000
G2 X102.708 Y90.769 I-.029 J.05 E.00559
M204 S10000
G1 X102.68 Y89.103 F42000
; LINE_WIDTH: 0.419992
G1 F20428
M204 S6000
G1 X83.795 Y89.103 E.36401
G1 X83.542 Y89.15 E.00497
G2 X83.25 Y89.441 I.207 J.499 E.00815
G1 X83.203 Y89.756 E.00613
G1 X83.203 Y107.604 E.34404
G1 X83.251 Y107.861 E.00503
G2 X83.541 Y108.15 I.497 J-.209 E.00809
G1 X83.857 Y108.197 E.00615
G1 X103.704 Y108.197 E.38257
G1 X103.961 Y108.149 E.00503
G2 X104.25 Y107.859 I-.209 J-.497 E.00809
G1 X104.297 Y107.543 E.00616
G1 X104.295 Y89.709 E.34375
G1 X104.235 Y89.406 E.00596
G1 X104.046 Y89.208 E.00528
G1 X103.81 Y89.121 E.00484
G1 X102.74 Y89.104 E.02063
M204 S10000
G1 X98.525 Y89.488 F42000
; LINE_WIDTH: 0.415145
G1 F20428
M204 S6000
G1 X88.975 Y89.488 E.1818
G3 X87.439 Y89.497 I-.91 J-22.825 E.02927
G1 X83.832 Y89.497 E.06867
G1 X83.65 Y89.553 E.00363
G1 X83.597 Y89.756 E.004
G1 X83.597 Y107.567 E.3391
G1 X83.652 Y107.75 E.00363
G1 X83.857 Y107.803 E.00403
G1 X87.38 Y107.803 E.06707
; LINE_WIDTH: 0.439532
G3 X88.652 Y107.808 I.602 J8.063 E.02576
; LINE_WIDTH: 0.415952
M73 P9 R11
G1 X98.726 Y107.811 E.1922
G3 X99.838 Y107.803 I.644 J12.343 E.02122
G1 X103.667 Y107.803 E.07306
G1 X103.85 Y107.748 E.00364
G1 X103.903 Y107.543 E.00404
G1 X103.9 Y89.709 E.34022
G1 X103.847 Y89.549 E.00322
G1 X103.661 Y89.498 E.00368
G3 X98.585 Y89.488 I-2.156 J-210.67 E.09684
M204 S10000
G1 X98.525 Y89.863 F42000
; LINE_WIDTH: 0.415108
G1 F20428
M204 S6000
G1 X99.086 Y89.894 E.01071
G1 X99.746 Y90.051 E.0129
G1 X100.472 Y90.368 E.01509
G1 X100.93 Y90.664 E.01038
G1 X101.5 Y91.186 E.01472
G1 X101.976 Y91.831 E.01526
G1 X102.223 Y92.313 E.01032
G1 X102.456 Y93.054 E.01478
G3 X102.541 Y93.674 I-3.833 J.839 E.01193
G1 X102.541 Y103.622 E.18938
G1 X102.422 Y104.391 E.0148
G3 X101.688 Y105.871 I-3.982 J-1.051 E.03167
G1 X101.517 Y106.097 E.00541
G1 X101.127 Y106.477 E.01036
G1 X100.576 Y106.872 E.0129
G1 X99.856 Y107.212 E.01517
G1 X99.329 Y107.369 E.01045
G3 X98.726 Y107.433 I-.756 J-4.289 E.01156
G1 X88.778 Y107.433 E.18938
; LINE_WIDTH: 0.419292
G1 X88.392 Y107.389 E.00747
; LINE_WIDTH: 0.421423
G1 X88.006 Y107.344 E.00751
G3 X85.986 Y106.1 I1.338 J-4.434 E.04642
G1 X85.528 Y105.476 E.01496
G1 X85.188 Y104.756 E.01541
G3 X84.959 Y103.626 I5.067 J-1.615 E.02233
G1 X84.953 Y93.876 E.18863
G1 X84.997 Y93.319 E.01081
G1 X85.15 Y92.659 E.01311
G1 X85.468 Y91.928 E.01541
G1 X85.764 Y91.47 E.01055
G1 X86.292 Y90.894 E.01512
G1 X86.717 Y90.558 E.01048
G1 X87.425 Y90.175 E.01557
G1 X88.154 Y89.936 E.01483
; LINE_WIDTH: 0.402116
G3 X88.975 Y89.863 I1.022 J6.761 E.01519
G1 X98.465 Y89.863 E.17461
M204 S10000
G1 X84.841 Y90.663 F42000
; LINE_WIDTH: 0.485132
G1 F20428
M204 S6000
G2 X84.838 Y90.762 I-.029 J.049 E.00529
M204 S10000
G1 X84.385 Y92.47 F42000
; LINE_WIDTH: 0.419992
G1 F20428
M204 S6000
G1 X84.749 Y91.603 E.01811
G1 X85.108 Y91.032 E.013
G1 X85.794 Y90.285 E.01954
G1 X84.385 Y90.285 E.02715
G1 X84.385 Y92.41 E.04094
M204 S10000
G1 X84.515 Y93.876 F42000
; LINE_WIDTH: 0.522172
G1 F20428
M204 S6000
G1 X84.555 Y93.216 E.01605
; LINE_WIDTH: 0.518059
G1 X84.625 Y93.001 E.00546
; LINE_WIDTH: 0.478832
G1 X84.696 Y92.785 E.00502
; LINE_WIDTH: 0.420455
G1 X84.766 Y92.569 E.00437
G1 X85.108 Y91.766 E.01686
G1 X85.436 Y91.251 E.01177
G1 X86.004 Y90.625 E.01632
G1 X86.478 Y90.245 E.01171
G1 X87.118 Y89.891 E.01411
G1 X83.991 Y89.891 E.06033
G1 X83.991 Y92.481 E.04997
; LINE_WIDTH: 0.439606
G1 X84.011 Y92.707 E.00459
; LINE_WIDTH: 0.478832
G1 X84.03 Y92.932 E.00502
; LINE_WIDTH: 0.510324
G1 X84.05 Y93.158 E.00537
G2 X84.035 Y93.876 I23.779 J.872 E.01702
G1 X84.036 Y103.627 E.23101
G1 X84.054 Y104.245 E.01465
; LINE_WIDTH: 0.524117
G1 X84.033 Y104.453 E.0051
; LINE_WIDTH: 0.482467
G1 X84.012 Y104.661 E.00467
; LINE_WIDTH: 0.42046
G1 X83.991 Y104.869 E.00404
G1 X83.991 Y107.409 E.04901
G1 X87.102 Y107.409 E.06003
G1 X86.701 Y107.197 E.00875
G1 X86.147 Y106.8 E.01315
G1 X85.707 Y106.379 E.01176
G1 X85.208 Y105.706 E.01616
G1 X84.829 Y104.919 E.01686
; LINE_WIDTH: 0.442857
G1 X84.721 Y104.63 E.00628
; LINE_WIDTH: 0.488587
G1 X84.614 Y104.341 E.00697
; LINE_WIDTH: 0.509612
G1 X84.571 Y104.211 E.00324
G1 X84.52 Y103.627 E.01387
G1 X84.515 Y93.936 E.22925
M204 S10000
G1 X85.347 Y93.876 F42000
; LINE_WIDTH: 0.419992
G1 F20428
M204 S6000
G1 X85.381 Y93.408 E.00904
G1 X85.534 Y92.748 E.01306
G1 X85.827 Y92.09 E.01387
G1 X86.112 Y91.664 E.00988
G1 X86.58 Y91.164 E.01321
G1 X86.985 Y90.854 E.00983
G1 X87.609 Y90.523 E.01362
G1 X88.269 Y90.321 E.0133
G3 X88.975 Y90.247 I1.012 J6.251 E.0137
G1 X98.525 Y90.247 E.18406
G1 X98.996 Y90.281 E.00911
G1 X99.656 Y90.435 E.01306
G1 X100.31 Y90.727 E.0138
G1 X100.736 Y91.012 E.00988
G1 X101.231 Y91.474 E.01305
G1 X101.656 Y92.06 E.01396
G1 X101.881 Y92.517 E.00981
G1 X102.079 Y93.168 E.01313
G1 X102.146 Y93.674 E.00983
G1 X102.146 Y103.622 E.19176
G1 X102.033 Y104.327 E.01375
G3 X101.259 Y105.794 I-3.823 J-1.08 E.03222
G1 X100.897 Y106.156 E.00988
G1 X100.346 Y106.552 E.01306
G1 X99.693 Y106.853 E.01387
G3 X98.726 Y107.046 I-1.181 J-3.386 E.01906
G1 X88.778 Y107.046 E.19176
G1 X88.073 Y106.933 E.01375
G3 X86.606 Y106.159 I1.079 J-3.822 E.03222
G1 X86.244 Y105.797 E.00988
G1 X85.848 Y105.246 E.01306
G1 X85.547 Y104.593 E.01387
G3 X85.354 Y103.626 I3.386 J-1.181 E.01906
G1 X85.347 Y93.936 E.18679
M204 S10000
G1 X84.39 Y104.869 F42000
; LINE_WIDTH: 0.419992
G1 F20428
M204 S6000
G2 X84.385 Y107.015 I224.637 J1.53 E.04135
G1 X85.792 Y107.015 E.02712
G1 X85.428 Y106.657 E.00983
G1 X84.888 Y105.936 E.01737
G1 X84.47 Y105.081 E.01833
G1 X84.411 Y104.925 E.00322
M204 S10000
G1 X84.848 Y106.531 F42000
; LINE_WIDTH: 0.497292
G1 F20428
M204 S6000
G2 X84.847 Y106.633 I-.029 J.051 E.00565
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X84.789 Y106.633 E-.18743
G1 X84.759 Y106.582 E-.19085
G1 X84.789 Y106.531 E-.19085
G1 X84.848 Y106.531 E-.19086
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X89.824 Y100.743 Z.72 F42000
G1 X104.393 Y83.797 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20428
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
; WIPE_START
G1 F21000
G1 X104.441 Y81.797 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.769 Y85.031 Z.72 F42000
G1 Z.32
G1 E.8 F1800
G1 F20428
M204 S6000
G1 X104.769 Y84.221 E.0168
G1 X103.969 Y84.221 E.01659
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.829 Y85.031 E.00625
M204 S250
G1 X104.36 Y85.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X104.36 Y84.63 E.01561
G1 X103.56 Y84.63 E.01542
G1 X103.56 Y73.44 E.2157
G1 X96.24 Y73.44 E.1411
G1 X95.84 Y73.44 E.00771
G1 F7145.347
G1 X95.44 Y73.44 E.00771
G1 F3228.211
G1 X95.44 Y73.571 E.00253
G1 F2279.241
G1 X95.44 Y73.69 E.00229
G1 F1560
G1 X92.36 Y73.69 E.05937
G1 F2279.241
G1 X92.36 Y73.571 E.00229
G1 F6913.126
G1 X92.36 Y73.06 E.00985
G1 F12000
G1 X92.76 Y73.06 E.00771
G1 X105.54 Y73.06 E.24634
G1 X105.54 Y85.44 E.23863
G1 X104.42 Y85.44 E.02159
; WIPE_START
M204 S6000
G1 X104.36 Y84.63 E-.30864
G1 X103.56 Y84.63 E-.304
G1 X103.56 Y84.242 E-.14736
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.931 Y84.465 Z.72 F42000
G1 X91.107 Y84.607 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20428
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F20428
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z.72 F42000
G1 X103.14 Y85.44 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X99.26 Y85.06 E.1411
G1 X99.66 Y85.06 E.00771
G1 F7145.347
G1 X100.06 Y85.06 E.00771
G1 F3228.211
G1 X100.06 Y84.929 E.00253
G1 F2279.241
G1 X100.06 Y84.81 E.00229
G1 F1560
G1 X103.14 Y84.81 E.05937
G1 F2279.241
G1 X103.14 Y84.929 E.00229
G1 F6239.149
G1 X103.14 Y85.38 E.00869
M204 S10000
G1 X102.935 Y85.125 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.246522
G1 F20428
M204 S6000
G1 X100.265 Y85.125 E.02883
; WIPE_START
G1 F21000
G1 X102.265 Y85.125 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.346 Y78.575 Z.72 F42000
G1 X95.235 Y73.375 Z.72
G1 Z.32
G1 E.8 F1800
G1 F20428
M204 S6000
G1 X92.565 Y73.375 E.02883
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X94.565 Y73.375 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X89.782 Y79.323 Z.72 F42000
G1 X85.533 Y84.607 Z.72
G1 Z.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20428
M204 S6000
G1 X76.467 Y84.607 E.18805
G3 X75.293 Y83.433 I-.005 J-1.168 E.03828
G1 X75.293 Y72.567 E.22539
G3 X76.467 Y71.393 I1.164 J-.009 E.03832
G1 X85.587 Y71.395 E.18917
G3 X86.707 Y72.567 I-.038 J1.157 E.03723
G1 X86.707 Y83.433 E.22539
G3 X85.593 Y84.605 I-1.164 J.009 E.03708
M204 S10000
G1 X85.557 Y85.029 F42000
G1 F20428
M204 S6000
G1 X85.54 Y85.031 E.00034
G1 X76.46 Y85.031 E.18834
G3 X74.869 Y83.44 I.004 J-1.594 E.0518
G1 X74.869 Y72.56 E.22568
G3 X76.46 Y70.969 I1.59 J-.001 E.05184
G1 X85.611 Y70.972 E.18982
G3 X87.131 Y72.56 I-.063 J1.581 E.05041
G1 X87.131 Y83.44 E.22568
G3 X85.858 Y84.999 I-1.59 J.001 E.0452
G1 X85.616 Y85.023 E.00504
M204 S250
G1 X85.597 Y85.435 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X85.547 Y85.44 E.00097
G1 X76.453 Y85.44 E.17528
G3 X74.46 Y83.447 I.012 J-2.006 E.06026
G1 X74.46 Y72.553 E.20997
G3 X76.453 Y70.56 I2.001 J.007 E.0603
G1 X85.635 Y70.563 E.17698
G3 X87.54 Y72.553 I-.086 J1.989 E.05865
G1 X87.54 Y83.447 E.20997
G3 X85.938 Y85.4 I-2.001 J-.007 E.0527
G1 X85.656 Y85.429 E.00546
; WIPE_START
M204 S6000
G1 X85.547 Y85.44 E-.04188
G1 X83.657 Y85.44 E-.71812
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.714 Y84.418 Z.72 F42000
G1 Z.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.429412
G1 F20428
M204 S6000
G2 X86.194 Y83.937 I-7.092 J-7.55 E.01343
G2 X86.359 Y83.202 I-.888 J-.585 E.01518
G1 X85.302 Y84.259 E.02948
G1 X84.732 Y84.259 E.01127
G1 X86.358 Y82.632 E.04541
G1 X86.358 Y82.061 E.01126
G1 X84.161 Y84.259 E.06134
G1 X83.59 Y84.259 E.01127
G1 X86.358 Y81.49 E.07727
G1 X86.358 Y80.92 E.01126
G1 X83.019 Y84.259 E.0932
G1 X82.448 Y84.259 E.01127
G1 X86.358 Y80.349 E.10912
G1 X86.358 Y79.778 E.01126
G1 X81.877 Y84.259 E.12505
G1 X81.306 Y84.259 E.01127
G1 X86.358 Y79.208 E.14098
G1 X86.357 Y78.637 E.01126
G1 X80.736 Y84.259 E.15691
G1 X80.165 Y84.259 E.01127
G1 X86.357 Y78.066 E.17284
G1 X86.357 Y77.495 E.01126
G1 X79.594 Y84.259 E.18877
G1 X79.023 Y84.259 E.01127
G1 X86.357 Y76.925 E.2047
G1 X86.357 Y76.354 E.01126
G1 X78.452 Y84.259 E.22063
M73 P10 R11
G1 X77.881 Y84.259 E.01127
G1 X86.357 Y75.783 E.23655
G1 X86.356 Y75.213 E.01126
G1 X77.31 Y84.259 E.25248
G1 X76.739 Y84.259 E.01127
G1 X86.356 Y74.642 E.26841
G1 X86.356 Y74.071 E.01126
G1 X76.209 Y84.218 E.2832
G3 X75.86 Y83.997 I.458 J-1.11 E.00821
G1 X86.356 Y73.5 E.29296
G1 X86.356 Y72.93 E.01126
G1 X75.665 Y83.621 E.29839
G3 X75.641 Y83.073 I2.395 J-.377 E.01083
G1 X86.335 Y72.379 E.29848
G2 X86.14 Y72.004 I-1.023 J.294 E.00841
G1 X75.641 Y82.502 E.29302
G1 X75.641 Y81.932 E.01127
G1 X85.789 Y71.784 E.28323
G2 X85.259 Y71.743 I-.369 J1.334 E.01056
G1 X75.641 Y81.361 E.26844
G1 X75.641 Y80.79 E.01127
G1 X84.688 Y71.743 E.2525
G1 X84.117 Y71.743 E.01127
G1 X75.641 Y80.219 E.23656
G1 X75.641 Y79.648 E.01127
G1 X83.546 Y71.743 E.22063
G1 X82.975 Y71.743 E.01127
G1 X75.641 Y79.077 E.20469
G1 X75.641 Y78.506 E.01127
G1 X82.404 Y71.744 E.18876
G1 X81.833 Y71.744 E.01127
G1 X75.641 Y77.936 E.17282
G1 X75.641 Y77.365 E.01127
G1 X81.262 Y71.744 E.15689
G1 X80.691 Y71.744 E.01127
G1 X75.641 Y76.794 E.14095
G1 X75.641 Y76.223 E.01127
G1 X80.121 Y71.744 E.12502
G1 X79.55 Y71.744 E.01127
G1 X75.641 Y75.652 E.10908
G1 X75.641 Y75.081 E.01127
G1 X78.979 Y71.744 E.09315
G1 X78.408 Y71.744 E.01127
G1 X75.641 Y74.51 E.07721
G1 X75.641 Y73.94 E.01127
G1 X77.837 Y71.744 E.06128
G1 X77.266 Y71.744 E.01127
G1 X75.641 Y73.369 E.04534
G1 X75.641 Y72.798 E.01127
G1 X76.695 Y71.744 E.0294
G2 X75.939 Y71.929 I-.146 J1.041 E.01572
G1 X75.482 Y72.386 E.01277
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X75.939 Y71.929 E-.24584
G1 X76.048 Y71.852 E-.05074
G1 X76.247 Y71.77 E-.08148
G1 X76.403 Y71.744 E-.06019
G1 X76.695 Y71.744 E-.11095
G1 X76.303 Y72.137 E-.21079
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 3/73
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.72 I-1.162 J.362 P1  F42000
G1 X86.78 Y105.759 Z.72
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19995
M204 S6000
G1 X86.711 Y105.689 E.00203
G3 X85.757 Y103.417 I2.305 J-2.305 E.05242
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.259 J.033 E.10483
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.033 J3.259 E.10483
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X87.029 Y105.968 I.033 J-3.259 E.04362
G1 X86.826 Y105.797 E.00551
M204 S10000
G1 X87.059 Y105.44 F42000
G1 F19995
M204 S6000
G1 X87.011 Y105.39 E.00146
G3 X86.181 Y103.41 I2.003 J-2.004 E.04566
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.287 Y105.632 I.024 J-2.833 E.03801
G1 X87.105 Y105.479 E.00494
M204 S250
G1 X87.319 Y105.124 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.299 Y105.101 E.00059
G3 X86.59 Y103.404 I1.713 J-1.713 E.03637
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.664 Y105.4 I.016 J-2.422 E.02727
G1 X87.366 Y105.161 E.00735
; WIPE_START
M204 S6000
G1 X87.299 Y105.101 E-.03422
G1 X86.996 Y104.739 E-.17932
G1 X86.773 Y104.322 E-.17956
G1 X86.636 Y103.87 E-.17952
G1 X86.59 Y103.404 E-.17822
G1 X86.59 Y103.379 E-.00917
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z.84 F42000
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19995
M204 S6000
G3 X82.793 Y107.633 I-.008 J-.965 E.03179
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.965 J-.008 E.0318
G1 X103.761 Y88.694 E.41471
G3 X104.707 Y89.667 I-.018 J.964 E.03122
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.965 J.008 E.0318
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F19995
M204 S6000
G3 X82.369 Y107.64 I.001 J-1.391 E.04531
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.391 J.001 E.04531
G1 X103.767 Y88.27 E.415
G3 X105.131 Y89.66 I-.027 J1.39 E.04474
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.391 J-.001 E.04531
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.75 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X83.401 Y109.403 E.00677
G3 X81.96 Y107.647 I.362 J-1.766 E.04739
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.803 J.009 E.05423
G1 X103.774 Y87.861 E.38591
G3 X105.54 Y89.653 I-.036 J1.801 E.05369
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.803 J-.009 E.05423
G1 X83.81 Y109.44 E.38429
; WIPE_START
M204 S6000
G1 X83.401 Y109.403 E-.15616
G1 X83.065 Y109.304 E-.13317
G1 X82.757 Y109.139 E-.13291
G1 X82.485 Y108.916 E-.13334
G1 X82.262 Y108.644 E-.13375
G1 X82.174 Y108.48 E-.07068
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.84 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 3 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer3 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.716 Y106.538
G1 Z.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.485032
G1 F19995
M204 S6000
G2 X102.714 Y106.638 I-.029 J.049 E.00529
M204 S10000
G1 X103.114 Y104.792 F42000
; LINE_WIDTH: 0.419992
G1 F19995
M204 S6000
G1 X102.931 Y105.333 E.01102
G3 X102.347 Y106.331 I-4.56 J-2 E.02234
G1 X101.703 Y107.015 E.01809
G1 X103.114 Y107.015 E.0272
G1 X103.114 Y104.852 E.04169
M204 S10000
G1 X102.979 Y93.674 F42000
; LINE_WIDTH: 0.5102
G1 F19995
M204 S6000
G1 X102.98 Y103.626 E.23572
G1 X102.93 Y104.208 E.01383
; LINE_WIDTH: 0.523759
G1 X102.832 Y104.475 E.00692
; LINE_WIDTH: 0.482252
G1 X102.734 Y104.741 E.00634
; LINE_WIDTH: 0.420642
G3 X102.064 Y106.049 I-5.279 J-1.882 E.02845
G1 X101.502 Y106.669 E.01617
G1 X100.806 Y107.192 E.0168
G1 X100.375 Y107.409 E.00932
G1 X103.509 Y107.409 E.06051
G1 X103.508 Y105.137 E.04386
; LINE_WIDTH: 0.439327
G1 X103.489 Y104.797 E.0069
; LINE_WIDTH: 0.477997
G1 X103.47 Y104.456 E.00754
; LINE_WIDTH: 0.510015
G3 X103.463 Y103.626 I13.916 J-.52 E.01966
G1 X103.462 Y93.674 E.23563
G1 X103.445 Y93.055 E.01466
; LINE_WIDTH: 0.523267
G1 X103.465 Y92.847 E.00508
; LINE_WIDTH: 0.481957
G1 X103.486 Y92.639 E.00466
; LINE_WIDTH: 0.420454
G1 X103.507 Y92.431 E.00403
G1 X103.506 Y89.892 E.049
G1 X100.38 Y89.892 E.06034
G1 X100.802 Y90.105 E.00913
G1 X101.353 Y90.5 E.01308
G1 X101.793 Y90.921 E.01176
G1 X102.292 Y91.594 E.01616
G1 X102.671 Y92.382 E.01687
; LINE_WIDTH: 0.43759
G1 X102.773 Y92.672 E.00619
; LINE_WIDTH: 0.472785
G1 X102.876 Y92.961 E.00672
; LINE_WIDTH: 0.503767
G1 X102.902 Y93.025 E.00161
; LINE_WIDTH: 0.526867
G1 X102.929 Y93.089 E.00169
G1 X102.974 Y93.614 E.01292
M204 S10000
G1 X103.109 Y92.431 F42000
; LINE_WIDTH: 0.419992
G1 F19995
M204 S6000
G2 X103.112 Y90.286 I-305.247 J-1.484 E.04134
G1 X101.708 Y90.286 E.02705
G1 X102.072 Y90.642 E.00981
G1 X102.612 Y91.364 E.01738
G1 X103.03 Y92.219 E.01833
G1 X103.088 Y92.375 E.00322
M204 S10000
G1 X102.71 Y90.667 F42000
; LINE_WIDTH: 0.495232
G1 F19995
M204 S6000
G2 X102.708 Y90.769 I-.029 J.05 E.00558
M204 S10000
G1 X102.68 Y89.104 F42000
; LINE_WIDTH: 0.419992
G1 F19995
M204 S6000
G1 X83.795 Y89.103 E.36402
G1 X83.543 Y89.15 E.00495
G2 X83.25 Y89.441 I.206 J.499 E.00816
G1 X83.203 Y89.756 E.00613
G1 X83.203 Y107.605 E.34405
G1 X83.25 Y107.858 E.00496
G2 X83.541 Y108.15 I.5 J-.207 E.00816
G1 X83.856 Y108.197 E.00613
G1 X103.705 Y108.197 E.3826
G1 X103.958 Y108.15 E.00497
G2 X104.25 Y107.859 I-.207 J-.499 E.00815
G1 X104.297 Y107.544 E.00613
G1 X104.295 Y89.709 E.34377
G1 X104.234 Y89.406 E.00596
G1 X104.045 Y89.207 E.0053
G1 X103.791 Y89.116 E.00519
G1 X102.74 Y89.104 E.02026
M204 S10000
G1 X88.979 Y89.488 F42000
; LINE_WIDTH: 0.420094
G1 F19995
M204 S6000
G3 X83.832 Y89.497 I-2.966 J-215.373 E.09925
G1 X83.649 Y89.553 E.00368
G1 X83.597 Y89.756 E.00403
G1 X83.597 Y107.568 E.34343
G1 X83.653 Y107.751 E.00368
G1 X83.856 Y107.803 E.00403
G1 X87.38 Y107.803 E.06795
; LINE_WIDTH: 0.439532
G3 X88.652 Y107.808 I.602 J8.064 E.02575
; LINE_WIDTH: 0.412943
G1 X98.726 Y107.811 E.19072
G3 X99.838 Y107.803 I.644 J12.315 E.02105
G1 X103.668 Y107.803 E.07251
G1 X103.851 Y107.747 E.00362
G1 X103.903 Y107.544 E.00396
G1 X103.9 Y89.71 E.33762
G1 X103.846 Y89.549 E.00322
G1 X103.668 Y89.498 E.0035
G3 X98.525 Y89.488 I-1.782 J-408.059 E.09737
G1 X89.039 Y89.488 E.17956
M204 S10000
G1 X88.979 Y89.863 F42000
; LINE_WIDTH: 0.411797
G1 F19995
M204 S6000
G1 X98.525 Y89.863 E.18016
G1 X99.091 Y89.895 E.0107
G1 X99.789 Y90.067 E.01356
G1 X100.475 Y90.369 E.01415
G1 X101.124 Y90.821 E.01492
G1 X101.514 Y91.2 E.01028
G1 X101.972 Y91.824 E.0146
G1 X102.312 Y92.545 E.01504
G3 X102.541 Y93.674 I-5.067 J1.615 E.02179
G1 X102.541 Y103.626 E.18784
G1 X102.477 Y104.148 E.00993
G1 X102.259 Y104.894 E.01467
M73 P11 R11
G3 X101.736 Y105.83 I-3.686 J-1.448 E.02029
G1 X101.214 Y106.4 E.0146
G1 X100.576 Y106.872 E.01497
G1 X99.856 Y107.212 E.01504
G1 X99.33 Y107.369 E.01037
G3 X98.726 Y107.433 I-.755 J-4.284 E.01146
G1 X88.778 Y107.433 E.18777
; LINE_WIDTH: 0.419292
G1 X88.392 Y107.389 E.00747
; LINE_WIDTH: 0.421395
G1 X88.006 Y107.344 E.00751
G3 X86.57 Y106.636 I1.598 J-5.046 E.03108
G1 X86 Y106.114 E.01497
G1 X85.528 Y105.476 E.01534
G1 X85.188 Y104.756 E.01541
G3 X84.959 Y103.626 I4.708 J-1.542 E.02234
G1 X84.953 Y93.876 E.18862
G1 X84.998 Y93.307 E.01103
G1 X85.154 Y92.644 E.01317
G1 X85.468 Y91.927 E.01515
G3 X86.361 Y90.832 I4.012 J2.359 E.02743
G1 X86.798 Y90.507 E.01053
G1 X87.398 Y90.185 E.01317
G1 X88.197 Y89.93 E.01624
; LINE_WIDTH: 0.417527
G1 X88.919 Y89.865 E.01388
M204 S10000
G1 X88.979 Y90.247 F42000
; LINE_WIDTH: 0.419992
G1 F19995
M204 S6000
G1 X98.525 Y90.247 E.18399
G1 X98.997 Y90.281 E.00914
G1 X99.696 Y90.45 E.01385
G1 X100.31 Y90.728 E.01299
G1 X100.894 Y91.141 E.01379
G1 X101.256 Y91.503 E.00987
G1 X101.652 Y92.054 E.01306
G1 X101.953 Y92.708 E.01387
G3 X102.146 Y93.674 I-3.427 J1.189 E.01906
G1 X102.146 Y103.626 E.19183
G1 X102.079 Y104.128 E.00976
G1 X101.882 Y104.78 E.01313
G3 X100.926 Y106.131 I-3.646 J-1.568 E.03214
G1 X100.346 Y106.552 E.0138
G1 X99.693 Y106.853 E.01387
G3 X98.726 Y107.046 I-1.182 J-3.389 E.01906
G1 X88.778 Y107.046 E.19176
G1 X88.073 Y106.933 E.01375
G3 X86.764 Y106.288 I1.102 J-3.888 E.02828
G1 X86.269 Y105.826 E.01307
G1 X85.848 Y105.246 E.0138
G1 X85.547 Y104.593 E.01387
G3 X85.354 Y103.626 I4.846 J-1.474 E.01903
G1 X85.347 Y93.876 E.18795
G1 X85.382 Y93.397 E.00924
G1 X85.538 Y92.735 E.01312
G1 X85.827 Y92.09 E.01362
G3 X86.581 Y91.162 I4.184 J2.628 E.02312
G1 X86.984 Y90.854 E.00976
G1 X87.584 Y90.533 E.01313
G1 X88.311 Y90.314 E.01463
G1 X88.92 Y90.252 E.01179
M204 S10000
G1 X84.848 Y90.667 F42000
; LINE_WIDTH: 0.497032
G1 F19995
M204 S6000
G2 X84.847 Y90.769 I-.029 J.051 E.00564
M204 S10000
G1 X84.386 Y92.463 F42000
; LINE_WIDTH: 0.419992
G1 F19995
M204 S6000
G1 X84.751 Y91.6 E.01806
G3 X85.426 Y90.645 I6.364 J3.78 E.02257
G1 X85.791 Y90.286 E.00988
G1 X84.385 Y90.285 E.02709
G2 X84.386 Y92.403 I389.853 J.954 E.04082
M204 S10000
G1 X84.515 Y93.876 F42000
; LINE_WIDTH: 0.518738
G1 F19995
M204 S6000
G3 X84.557 Y93.203 I5.98 J.027 E.01627
; LINE_WIDTH: 0.518859
G1 X84.628 Y92.987 E.00549
; LINE_WIDTH: 0.479312
G1 X84.699 Y92.77 E.00505
; LINE_WIDTH: 0.420463
G1 X84.771 Y92.554 E.0044
G1 X85.11 Y91.764 E.01659
G3 X86.121 Y90.519 I4.54 J2.656 E.03107
G3 X87.112 Y89.891 I2.702 J3.167 E.02271
G1 X83.991 Y89.891 E.06022
G1 X83.991 Y92.463 E.04963
; LINE_WIDTH: 0.439766
G1 X84.011 Y92.69 E.00461
; LINE_WIDTH: 0.479312
G1 X84.031 Y92.917 E.00505
; LINE_WIDTH: 0.510385
G1 X84.051 Y93.144 E.0054
G2 X84.035 Y93.876 I23.971 J.889 E.01736
G1 X84.036 Y103.627 E.23104
G1 X84.054 Y104.245 E.01465
; LINE_WIDTH: 0.524134
G1 X84.033 Y104.453 E.0051
; LINE_WIDTH: 0.482477
G1 X84.012 Y104.661 E.00467
; LINE_WIDTH: 0.42046
G1 X83.991 Y104.869 E.00404
G1 X83.991 Y107.409 E.04901
G1 X87.102 Y107.409 E.06003
G3 X85.731 Y106.402 I2.166 J-4.386 E.033
G1 X85.208 Y105.706 E.01679
G1 X84.829 Y104.919 E.01686
; LINE_WIDTH: 0.44286
G1 X84.722 Y104.63 E.00628
; LINE_WIDTH: 0.488595
G1 X84.614 Y104.341 E.00697
; LINE_WIDTH: 0.509613
G1 X84.571 Y104.211 E.00324
G1 X84.52 Y103.627 E.01388
G1 X84.515 Y93.936 E.22925
M204 S10000
G1 X84.39 Y104.869 F42000
; LINE_WIDTH: 0.419992
G1 F19995
M204 S6000
G2 X84.385 Y107.015 I223.28 J1.528 E.04135
G1 X85.809 Y107.015 E.02744
G1 X85.283 Y106.486 E.01437
G1 X84.888 Y105.936 E.01306
G1 X84.47 Y105.082 E.01833
G1 X84.411 Y104.926 E.00322
M204 S10000
G1 X84.848 Y106.531 F42000
; LINE_WIDTH: 0.497272
G1 F19995
M204 S6000
G2 X84.847 Y106.633 I-.029 J.051 E.00565
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X84.789 Y106.633 E-.18743
G1 X84.759 Y106.582 E-.19085
G1 X84.789 Y106.531 E-.19085
G1 X84.848 Y106.531 E-.19086
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X89.824 Y100.743 Z.84 F42000
G1 X104.393 Y83.797 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19995
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
; WIPE_START
G1 F21000
M73 P11 R10
G1 X104.441 Y81.797 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.769 Y85.031 Z.84 F42000
G1 Z.44
G1 E.8 F1800
G1 F19995
M204 S6000
G1 X104.769 Y84.221 E.0168
G1 X103.969 Y84.221 E.01659
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.829 Y85.031 E.00625
M204 S250
G1 X104.36 Y85.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X104.36 Y84.63 E.01561
G1 X103.56 Y84.63 E.01542
G1 X103.56 Y73.44 E.2157
G1 X96.24 Y73.44 E.1411
G1 X95.84 Y73.44 E.00771
G1 F10347.103
G1 X95.44 Y73.44 E.00771
G1 F5477.169
G1 X95.44 Y73.731 E.00561
G1 F2899.481
G1 X95.44 Y73.81 E.00152
G1 F2340
G1 X92.36 Y73.81 E.05937
G1 F2899.481
G1 X92.36 Y73.731 E.00152
G1 F6651.975
G1 X92.36 Y73.331 E.00771
G1 F10067.265
G1 X92.36 Y73.06 E.00522
G1 F12000
G1 X92.76 Y73.06 E.00771
G1 X105.54 Y73.06 E.24634
G1 X105.54 Y85.44 E.23863
G1 X104.42 Y85.44 E.02159
; WIPE_START
M204 S6000
G1 X104.36 Y84.63 E-.30864
G1 X103.56 Y84.63 E-.304
G1 X103.56 Y84.242 E-.14736
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.931 Y84.465 Z.84 F42000
G1 X91.107 Y84.607 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19995
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F19995
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z.84 F42000
G1 X103.14 Y85.44 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X99.26 Y85.06 E.1411
G1 X99.66 Y85.06 E.00771
G1 F10347.103
G1 X100.06 Y85.06 E.00771
G1 F5477.169
G1 X100.06 Y84.769 E.00561
G1 F2899.481
G1 X100.06 Y84.69 E.00152
G1 F2340
G1 X103.14 Y84.69 E.05937
G1 F2899.481
G1 X103.14 Y84.769 E.00152
G1 F6651.975
G1 X103.14 Y85.169 E.00771
G1 F9250.37
G1 X103.14 Y85.38 E.00407
M204 S10000
G1 X102.935 Y85.065 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.366522
G1 F19995
M204 S6000
G1 X100.265 Y85.065 E.0445
; WIPE_START
G1 F21000
G1 X102.265 Y85.065 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.317 Y78.533 Z.84 F42000
G1 X95.235 Y73.435 Z.84
G1 Z.44
G1 E.8 F1800
G1 F19995
M204 S6000
G1 X92.565 Y73.435 E.0445
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X94.565 Y73.435 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X89.766 Y79.37 Z.84 F42000
G1 X85.532 Y84.607 Z.84
G1 Z.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19995
M204 S6000
G1 X76.467 Y84.607 E.18802
G3 X75.293 Y83.433 I-.01 J-1.164 E.03833
G1 X75.293 Y72.567 E.22538
G3 X76.467 Y71.393 I1.164 J-.01 E.03832
G1 X85.608 Y71.396 E.18961
G1 X85.625 Y71.397 E.00036
G3 X86.707 Y72.567 I-.078 J1.156 E.03644
G1 X86.707 Y83.433 E.22538
G3 X85.592 Y84.606 I-1.164 J.01 E.03711
M204 S10000
G1 X85.553 Y85.03 F42000
G1 F19995
M204 S6000
G1 X85.54 Y85.031 E.00027
G1 X76.46 Y85.031 E.18834
G3 X74.869 Y83.44 I-.001 J-1.59 E.05184
G1 X74.869 Y72.56 E.22568
G3 X76.46 Y70.969 I1.59 J-.001 E.05184
G1 X85.615 Y70.972 E.18991
G3 X87.131 Y72.56 I-.066 J1.58 E.05033
G1 X87.131 Y83.44 E.22568
G3 X85.858 Y84.999 I-1.59 J.001 E.0452
G1 X85.613 Y85.024 E.00512
M204 S250
G1 X85.593 Y85.435 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X85.547 Y85.44 E.0009
G1 X76.453 Y85.44 E.17528
G3 X74.46 Y83.447 I.007 J-2.001 E.0603
G1 X74.46 Y72.553 E.20997
G3 X76.453 Y70.56 I2.001 J.007 E.0603
G1 X85.622 Y70.562 E.17673
G3 X87.54 Y72.553 I-.073 J1.99 E.0589
G1 X87.54 Y83.447 E.20997
G3 X85.938 Y85.4 I-2.001 J-.007 E.0527
G1 X85.653 Y85.429 E.00553
; WIPE_START
M204 S6000
G1 X85.547 Y85.44 E-.04051
G1 X83.653 Y85.44 E-.71949
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.299 Y84.421 Z.84 F42000
G1 Z.44
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.429292
G1 F19995
M204 S6000
G1 X75.796 Y83.917 E.01406
G1 X75.73 Y83.812 E.00246
G3 X75.641 Y83.192 I1.274 J-.498 E.01245
G1 X76.708 Y84.259 E.02975
G1 X77.278 Y84.259 E.01126
G1 X75.641 Y82.622 E.04567
G1 X75.641 Y82.051 E.01126
G1 X77.849 Y84.259 E.0616
G1 X78.42 Y84.259 E.01126
G1 X75.641 Y81.48 E.07752
G1 X75.641 Y80.91 E.01126
G1 X78.99 Y84.259 E.09344
G1 X79.561 Y84.259 E.01126
G1 X75.641 Y80.339 E.10937
G1 X75.641 Y79.768 E.01126
G1 X80.132 Y84.259 E.12529
G1 X80.702 Y84.259 E.01126
G1 X75.641 Y79.198 E.14122
G1 X75.641 Y78.627 E.01126
G1 X81.273 Y84.259 E.15714
G1 X81.844 Y84.259 E.01126
G1 X75.641 Y78.056 E.17306
G1 X75.641 Y77.486 E.01126
G1 X82.414 Y84.259 E.18899
G1 X82.985 Y84.259 E.01126
G1 X75.641 Y76.915 E.20491
G1 X75.641 Y76.344 E.01126
G1 X83.556 Y84.259 E.22083
G1 X84.127 Y84.259 E.01126
G1 X75.641 Y75.773 E.23676
G1 X75.641 Y75.203 E.01126
G1 X84.697 Y84.259 E.25268
G1 X85.268 Y84.259 E.01126
G1 X75.641 Y74.632 E.26861
G1 X75.641 Y74.061 E.01126
G1 X85.791 Y84.211 E.2832
G2 X86.14 Y83.989 I-.187 J-.678 E.00828
G1 X75.641 Y73.491 E.29293
M73 P12 R10
G1 X75.641 Y72.92 E.01126
G1 X86.336 Y83.614 E.2984
G2 X86.359 Y83.067 I-1.969 J-.357 E.01085
G1 X75.667 Y72.375 E.29833
G3 X75.864 Y72.001 I.98 J.279 E.00839
G1 X86.358 Y82.496 E.29282
G1 X86.358 Y81.925 E.01126
G1 X76.216 Y71.783 E.28299
G3 X76.748 Y71.744 I.363 J1.32 E.0106
G1 X86.358 Y81.354 E.26813
G1 X86.358 Y80.783 E.01126
G1 X77.319 Y71.744 E.25221
G1 X77.89 Y71.744 E.01126
G1 X86.358 Y80.212 E.23628
G1 X86.358 Y79.641 E.01126
G1 X78.46 Y71.744 E.22035
G1 X79.031 Y71.744 E.01126
G1 X86.357 Y79.071 E.20443
G1 X86.357 Y78.5 E.01126
G1 X79.602 Y71.744 E.1885
G1 X80.172 Y71.744 E.01126
G1 X86.357 Y77.929 E.17257
G1 X86.357 Y77.358 E.01126
G1 X80.743 Y71.744 E.15664
G1 X81.314 Y71.744 E.01126
G1 X86.357 Y76.787 E.14072
G1 X86.357 Y76.216 E.01126
G1 X81.884 Y71.744 E.12479
G1 X82.455 Y71.744 E.01126
G1 X86.357 Y75.646 E.10886
G1 X86.356 Y75.075 E.01126
G1 X83.026 Y71.744 E.09294
G1 X83.596 Y71.744 E.01126
G1 X86.356 Y74.504 E.07701
G1 X86.356 Y73.933 E.01126
G1 X84.167 Y71.744 E.06108
G1 X84.738 Y71.744 E.01126
G1 X86.356 Y73.362 E.04515
G1 X86.356 Y72.791 E.01126
G1 X85.308 Y71.744 E.02923
G1 X85.587 Y71.744 E.00551
G3 X86.091 Y71.956 I-.037 J.793 E.011
G1 X86.515 Y72.38 E.01184
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X86.091 Y71.956 E-.22807
G1 X85.998 Y71.879 E-.04561
G1 X85.859 Y71.805 E-.06004
G1 X85.587 Y71.744 E-.10568
G1 X85.308 Y71.744 E-.10604
G1 X85.708 Y72.143 E-.21456
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 4/73
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.84 I-1.216 J.038 P1  F42000
G1 X86.77 Y105.754 Z.84
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20156
M204 S6000
G1 X86.711 Y105.689 E.00183
G3 X85.757 Y103.417 I2.305 J-2.305 E.05241
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.259 J.033 E.10483
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.033 J3.259 E.10483
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X86.865 Y105.834 I.033 J-3.259 E.04802
G1 X86.816 Y105.793 E.00133
M204 S10000
G1 X87.062 Y105.44 F42000
G1 F20156
M204 S6000
G1 X87.011 Y105.389 E.0015
G3 X86.181 Y103.41 I2.003 J-2.003 E.04565
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.433 Y105.737 I.024 J-2.833 E.03429
G1 X87.109 Y105.477 E.00861
M204 S250
G1 X87.321 Y105.125 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.299 Y105.101 E.00063
G3 X86.59 Y103.404 I1.713 J-1.713 E.03637
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.662 Y105.399 I.016 J-2.422 E.02729
G1 X87.368 Y105.162 E.00728
; WIPE_START
M204 S6000
G1 X87.299 Y105.101 E-.03504
G1 X86.996 Y104.739 E-.17935
G1 X86.838 Y104.465 E-.12037
G1 X86.759 Y104.283 E-.07511
G1 X86.636 Y103.87 E-.16379
G1 X86.59 Y103.404 E-.17821
G1 X86.59 Y103.382 E-.00814
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z.96 F42000
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20156
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03182
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.963 J-.011 E.03181
G1 X103.769 Y88.695 E.4149
G3 X104.707 Y89.667 I-.024 J.961 E.03106
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.963 J.011 E.03182
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F20156
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.389 J-.002 E.04533
G1 X103.776 Y88.27 E.41519
G3 X105.131 Y89.66 I-.033 J1.387 E.04458
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.751 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X83.401 Y109.404 E.00678
G3 X81.96 Y107.647 I.359 J-1.764 E.04741
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.006 E.05425
G1 X103.783 Y87.861 E.38608
G3 X105.54 Y89.653 I-.041 J1.798 E.05355
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.811 Y109.44 E.38428
; WIPE_START
M204 S6000
G1 X83.401 Y109.404 E-.1563
G1 X83.065 Y109.304 E-.13322
G1 X82.756 Y109.138 E-.13339
G1 X82.484 Y108.916 E-.1333
G1 X82.262 Y108.644 E-.13335
G1 X82.174 Y108.481 E-.07044
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.96 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 4 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer4 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.714 Y106.534
G1 Z.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.490952
G1 F20156
M204 S6000
G2 X102.712 Y106.635 I-.029 J.05 E.00546
M204 S10000
G1 X103.114 Y104.792 F42000
; LINE_WIDTH: 0.419992
G1 F20156
M204 S6000
G1 X102.912 Y105.369 E.01179
G3 X101.707 Y107.015 I-4.417 J-1.971 E.03961
G1 X103.114 Y107.015 E.02713
G1 X103.114 Y104.852 E.04168
M204 S10000
G1 X102.979 Y93.674 F42000
; LINE_WIDTH: 0.510201
G1 F20156
M204 S6000
G1 X102.98 Y103.626 E.23572
G1 X102.93 Y104.208 E.01383
; LINE_WIDTH: 0.523767
G1 X102.832 Y104.473 E.00689
; LINE_WIDTH: 0.482257
G1 X102.735 Y104.739 E.00632
; LINE_WIDTH: 0.420642
G1 X102.638 Y105.005 E.00546
G1 X102.244 Y105.784 E.01686
G3 X101.479 Y106.693 I-3.657 J-2.301 E.02301
G1 X100.803 Y107.194 E.01624
G1 X100.398 Y107.409 E.00885
G1 X103.509 Y107.409 E.06006
G1 X103.508 Y105.134 E.04393
; LINE_WIDTH: 0.439345
G1 X103.489 Y104.795 E.00686
; LINE_WIDTH: 0.47805
G1 X103.47 Y104.456 E.00751
; LINE_WIDTH: 0.510017
G3 X103.463 Y103.626 I13.93 J-.519 E.01965
G1 X103.462 Y93.674 E.23563
G1 X103.445 Y93.055 E.01466
; LINE_WIDTH: 0.523267
G1 X103.465 Y92.847 E.00509
; LINE_WIDTH: 0.481957
G1 X103.486 Y92.639 E.00466
; LINE_WIDTH: 0.420454
G1 X103.507 Y92.431 E.00403
G1 X103.506 Y89.892 E.04899
G1 X100.381 Y89.892 E.06031
G1 X100.802 Y90.105 E.0091
G1 X101.353 Y90.5 E.01308
G1 X101.793 Y90.922 E.01177
G1 X102.292 Y91.594 E.01616
G1 X102.671 Y92.381 E.01686
; LINE_WIDTH: 0.437587
G1 X102.773 Y92.671 E.0062
; LINE_WIDTH: 0.472777
G1 X102.876 Y92.961 E.00672
; LINE_WIDTH: 0.50376
G1 X102.902 Y93.025 E.00161
; LINE_WIDTH: 0.526867
G1 X102.929 Y93.089 E.00169
G1 X102.974 Y93.614 E.01292
M204 S10000
G1 X103.109 Y92.431 F42000
; LINE_WIDTH: 0.419992
G1 F20156
M204 S6000
G2 X103.112 Y90.287 I-300.381 J-1.484 E.04133
G1 X101.709 Y90.286 E.02705
G1 X102.072 Y90.643 E.00981
G1 X102.612 Y91.364 E.01737
G1 X103.03 Y92.218 E.01833
G1 X103.088 Y92.375 E.00322
M204 S10000
G1 X102.71 Y90.668 F42000
; LINE_WIDTH: 0.495052
G1 F20156
M204 S6000
G2 X102.708 Y90.769 I-.029 J.05 E.00558
M204 S10000
G1 X102.68 Y89.104 F42000
; LINE_WIDTH: 0.419992
G1 F20156
M204 S6000
G1 X83.795 Y89.103 E.36402
G1 X83.542 Y89.15 E.00497
G2 X83.248 Y89.447 I.207 J.498 E.00826
G1 X83.203 Y89.755 E.00601
G1 X83.203 Y107.605 E.34406
G1 X83.25 Y107.858 E.00497
G2 X83.542 Y108.15 I.498 J-.206 E.00815
G1 X83.856 Y108.197 E.00612
G1 X103.705 Y108.197 E.3826
G1 X103.958 Y108.15 E.00497
G2 X104.25 Y107.859 I-.207 J-.498 E.00815
G1 X104.297 Y107.544 E.00613
G1 X104.295 Y89.703 E.3439
G1 X104.243 Y89.425 E.00545
G1 X104.054 Y89.214 E.00545
G1 X103.821 Y89.121 E.00485
G1 X102.74 Y89.105 E.02082
M204 S10000
G1 X98.525 Y89.488 F42000
; LINE_WIDTH: 0.415102
G1 F20156
M204 S6000
G1 X88.975 Y89.488 E.18178
G3 X87.464 Y89.497 I-.896 J-22.225 E.02878
G1 X83.832 Y89.497 E.06914
G1 X83.653 Y89.55 E.00355
G1 X83.597 Y89.755 E.00405
G1 X83.597 Y107.568 E.33909
G1 X83.651 Y107.749 E.00359
G1 X83.856 Y107.803 E.00403
G1 X87.38 Y107.803 E.06709
; LINE_WIDTH: 0.439518
G3 X88.652 Y107.808 I.602 J8.069 E.02575
; LINE_WIDTH: 0.404144
G1 X98.722 Y107.811 E.18632
; LINE_WIDTH: 0.419285
G1 X99.126 Y107.796 E.00777
; LINE_WIDTH: 0.420983
G3 X100.12 Y107.803 I.449 J6.577 E.01923
G1 X103.668 Y107.803 E.06856
G1 X103.849 Y107.749 E.00364
G1 X103.903 Y107.544 E.00409
G1 X103.9 Y89.703 E.34477
G1 X103.853 Y89.554 E.00301
G1 X103.675 Y89.498 E.00362
G2 X99.139 Y89.501 I-1.936 J549.047 E.08764
; LINE_WIDTH: 0.413682
G1 X98.585 Y89.489 E.01053
M204 S10000
G1 X98.525 Y89.863 F42000
; LINE_WIDTH: 0.419913
G1 F20156
M204 S6000
G1 X99.092 Y89.895 E.01095
G1 X99.8 Y90.071 E.01406
G1 X100.475 Y90.369 E.01422
G1 X101.123 Y90.82 E.01521
G1 X101.515 Y91.2 E.01051
G1 X101.972 Y91.824 E.0149
G1 X102.312 Y92.544 E.01535
G3 X102.541 Y93.674 I-5.066 J1.615 E.02226
G1 X102.541 Y103.626 E.19179
G1 X102.477 Y104.148 E.01014
G1 X102.261 Y104.891 E.01491
G1 X101.896 Y105.599 E.01534
G3 X101.2 Y106.414 I-3.333 J-2.139 E.02073
G1 X100.573 Y106.874 E.01498
G1 X100.084 Y107.124 E.01058
; LINE_WIDTH: 0.407372
G1 X99.59 Y107.313 E.00989
G1 X98.722 Y107.433 E.01633
G1 X88.778 Y107.433 E.18555
; LINE_WIDTH: 0.419285
G1 X88.392 Y107.389 E.00747
; LINE_WIDTH: 0.421407
G1 X88.006 Y107.345 E.00751
G3 X85.986 Y106.1 I1.338 J-4.434 E.04642
G1 X85.528 Y105.476 E.01497
G1 X85.188 Y104.755 E.01542
G3 X84.959 Y103.626 I5.067 J-1.615 E.02233
G1 X84.953 Y93.876 E.18863
G1 X84.997 Y93.318 E.01082
G1 X85.153 Y92.647 E.01332
G1 X85.353 Y92.147 E.01042
G1 X85.753 Y91.487 E.01494
G1 X86.286 Y90.9 E.01534
G1 X86.927 Y90.426 E.01543
G1 X87.467 Y90.156 E.01166
G1 X88.155 Y89.936 E.01398
; LINE_WIDTH: 0.401985
G3 X88.975 Y89.863 I1.023 J6.816 E.01516
G1 X98.465 Y89.863 E.17455
M204 S10000
G1 X84.841 Y90.663 F42000
; LINE_WIDTH: 0.485092
G1 F20156
M204 S6000
G2 X84.838 Y90.762 I-.029 J.049 E.00529
M204 S10000
G1 X84.385 Y92.468 F42000
; LINE_WIDTH: 0.419992
G1 F20156
M204 S6000
G1 X84.625 Y91.844 E.01287
G1 X85.083 Y91.071 E.01732
G1 X85.71 Y90.362 E.01825
G1 X85.797 Y90.286 E.00222
G1 X84.385 Y90.285 E.0272
G1 X84.385 Y92.408 E.04091
M204 S10000
G1 X84.515 Y93.876 F42000
; LINE_WIDTH: 0.522247
G1 F20156
M204 S6000
M73 P13 R10
G1 X84.555 Y93.215 E.01608
; LINE_WIDTH: 0.518184
G1 X84.627 Y92.996 E.00555
; LINE_WIDTH: 0.478907
G1 X84.698 Y92.777 E.0051
; LINE_WIDTH: 0.420465
G3 X85.418 Y91.279 I5.14 J1.55 E.03221
G1 X85.998 Y90.631 E.01679
G1 X86.698 Y90.105 E.01688
G1 X87.108 Y89.891 E.00893
G1 X83.991 Y89.891 E.06015
G1 X83.991 Y92.468 E.04973
; LINE_WIDTH: 0.439631
G1 X84.011 Y92.698 E.00466
; LINE_WIDTH: 0.478907
G1 X84.03 Y92.927 E.0051
; LINE_WIDTH: 0.510336
G1 X84.05 Y93.157 E.00546
G2 X84.035 Y93.876 I23.71 J.873 E.01705
G1 X84.036 Y103.627 E.23101
G1 X84.054 Y104.245 E.01465
; LINE_WIDTH: 0.524142
G1 X84.033 Y104.453 E.00509
; LINE_WIDTH: 0.482482
G1 X84.012 Y104.661 E.00467
; LINE_WIDTH: 0.42046
G1 X83.991 Y104.869 E.00403
G1 X83.991 Y107.409 E.04901
G1 X87.102 Y107.409 E.06003
G1 X86.701 Y107.197 E.00875
G1 X86.147 Y106.8 E.01315
G1 X85.707 Y106.379 E.01176
G1 X85.208 Y105.706 E.01616
G1 X84.829 Y104.918 E.01687
; LINE_WIDTH: 0.442872
G1 X84.721 Y104.63 E.00628
; LINE_WIDTH: 0.488632
G1 X84.614 Y104.341 E.00697
; LINE_WIDTH: 0.509614
G1 X84.571 Y104.211 E.00324
G1 X84.52 Y103.627 E.01388
G1 X84.515 Y93.936 E.22925
M204 S10000
G1 X85.347 Y93.876 F42000
; LINE_WIDTH: 0.419992
G1 F20156
M204 S6000
G1 X85.381 Y93.407 E.00905
G1 X85.537 Y92.737 E.01327
G1 X85.731 Y92.27 E.00973
G1 X86.088 Y91.695 E.01306
G1 X86.574 Y91.169 E.0138
G1 X87.157 Y90.746 E.01389
G1 X87.638 Y90.512 E.0103
G1 X88.27 Y90.321 E.01272
G3 X88.975 Y90.247 I1.017 J6.303 E.01369
G1 X98.525 Y90.247 E.18406
G1 X98.998 Y90.281 E.00915
G1 X99.707 Y90.454 E.01407
G1 X100.31 Y90.728 E.01277
G1 X100.894 Y91.141 E.01378
G1 X101.257 Y91.504 E.00989
G1 X101.652 Y92.054 E.01306
G1 X101.953 Y92.707 E.01387
G3 X102.146 Y93.674 I-3.427 J1.19 E.01906
G1 X102.146 Y103.626 E.19183
G1 X102.079 Y104.128 E.00976
G1 X101.883 Y104.777 E.01307
G1 X101.548 Y105.413 E.01386
G3 X100.343 Y106.554 I-3.272 J-2.249 E.03222
G3 X98.722 Y107.046 I-1.923 J-3.412 E.03291
G1 X88.778 Y107.046 E.19169
G1 X88.073 Y106.933 E.01375
G3 X86.606 Y106.159 I1.079 J-3.822 E.03222
G1 X86.244 Y105.797 E.00987
G1 X85.848 Y105.246 E.01307
G1 X85.547 Y104.592 E.01388
G3 X85.354 Y103.626 I3.389 J-1.182 E.01905
G1 X85.347 Y93.936 E.18679
M204 S10000
G1 X84.39 Y104.869 F42000
; LINE_WIDTH: 0.419992
G1 F20156
M204 S6000
G2 X84.385 Y107.015 I227.909 J1.531 E.04136
G1 X85.792 Y107.015 E.02712
G1 X85.428 Y106.658 E.00983
G1 X84.888 Y105.936 E.01738
G1 X84.47 Y105.081 E.01834
G1 X84.411 Y104.925 E.00322
M204 S10000
G1 X84.848 Y106.531 F42000
; LINE_WIDTH: 0.497312
G1 F20156
M204 S6000
G2 X84.847 Y106.633 I-.029 J.051 E.00565
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X84.789 Y106.633 E-.18743
G1 X84.759 Y106.582 E-.19085
G1 X84.789 Y106.531 E-.19085
G1 X84.848 Y106.531 E-.19086
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X89.798 Y100.721 Z.96 F42000
G1 X103.56 Y84.57 Z.96
G1 Z.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2622.885
M204 S5000
G1 X103.519 Y84.57 E.00079
G1 F2340
G1 X100.06 Y84.57 E.06667
G1 F2899.481
G1 X100.06 Y84.649 E.00152
G1 F6776.869
G1 X100.06 Y85.06 E.00792
G1 F12000
G1 X99.66 Y85.06 E.00771
G1 X91.94 Y85.06 E.14881
G1 X91.94 Y75.13 E.19141
G1 X91.94 Y74.73 E.00771
G1 F11372.033
G1 X91.94 Y74.33 E.00771
G1 F6229.459
G1 X91.94 Y73.93 E.00771
G1 F2622.885
G1 X91.981 Y73.93 E.00079
G1 F2340
G1 X95.44 Y73.93 E.06667
G1 F2899.481
G1 X95.44 Y73.851 E.00152
G1 F6776.869
G1 X95.44 Y73.44 E.00792
G1 F12000
G1 X95.84 Y73.44 E.00771
G1 X103.56 Y73.44 E.14881
G1 X103.56 Y84.51 E.21338
; WIPE_START
M204 S6000
G1 X103.519 Y84.57 E-.02761
G1 X101.592 Y84.57 E-.73239
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.959 Y84.57 Z.96 F42000
G1 X91.107 Y84.57 Z.96
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20156
M204 S6000
G1 X91.107 Y84.607 E.00076
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.51 E.20341
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F20156
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.999 Y83.978 Z.96 F42000
G1 X104.393 Y83.797 Z.96
G1 Z.56
G1 E.8 F1800
G1 F20156
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F20156
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
; WIPE_START
G1 F21000
G1 X104.018 Y82.221 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.14 Y85.44 Z.96 F42000
G1 Z.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.581 Y73.87 E.0085
G1 X91.981 Y73.87 E.00771
G1 F7800
G1 X92.36 Y73.87 E.00731
G1 F8034.124
G1 X92.36 Y73.851 E.00037
G1 F12000
G1 X92.36 Y73.451 E.00771
G1 X92.36 Y73.06 E.00754
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.919 Y84.63 E.0085
G1 X103.519 Y84.63 E.00771
G1 F7800
G1 X103.14 Y84.63 E.00731
G1 F8034.124
G1 X103.14 Y84.649 E.00037
G1 F12000
G1 X103.14 Y85.049 E.00771
G1 X103.14 Y85.38 E.00638
M204 S10000
G1 X102.935 Y85.005 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.486522
G1 F20156
M204 S6000
G1 X100.265 Y85.005 E.06017
; WIPE_START
G1 F21000
G1 X102.265 Y85.005 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.287 Y78.491 Z.96 F42000
G1 X95.235 Y73.495 Z.96
G1 Z.56
G1 E.8 F1800
G1 F20156
M204 S6000
G1 X92.565 Y73.495 E.06017
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X94.565 Y73.495 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X89.748 Y79.416 Z.96 F42000
G1 X85.526 Y84.607 Z.96
G1 Z.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F20156
M204 S6000
G1 X76.467 Y84.607 E.18792
G3 X75.293 Y83.433 I-.009 J-1.164 E.03832
G1 X75.293 Y72.567 E.22539
G3 X76.467 Y71.393 I1.164 J-.009 E.03832
G1 X85.587 Y71.395 E.18917
G3 X86.707 Y72.567 I-.038 J1.157 E.03724
G1 X86.707 Y83.433 E.22539
G3 X85.586 Y84.606 I-1.16 J.014 E.03725
M204 S10000
G1 X85.526 Y85.031 F42000
G1 F20156
M204 S6000
G1 X76.46 Y85.031 E.18806
G3 X74.869 Y83.44 I-.001 J-1.59 E.05184
G1 X74.869 Y72.56 E.22568
G3 X76.46 Y70.969 I1.59 J-.001 E.05184
G1 X85.594 Y70.971 E.18946
G3 X87.131 Y72.56 I-.045 J1.581 E.05077
G1 X87.131 Y83.44 E.22568
G3 X85.586 Y85.03 I-1.584 J.007 E.05094
M204 S250
G1 X85.589 Y85.436 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X85.547 Y85.44 E.00083
G1 X76.453 Y85.44 E.17528
G3 X74.46 Y83.447 I.007 J-2.001 E.0603
G1 X74.46 Y72.553 E.20997
G3 X76.453 Y70.56 I2.001 J.007 E.0603
G1 X85.6 Y70.562 E.17632
G3 X87.54 Y72.553 I-.052 J1.99 E.05932
G1 X87.54 Y83.447 E.20997
G3 X85.938 Y85.401 I-1.993 J.001 E.05276
G1 X85.649 Y85.43 E.0056
; WIPE_START
M204 S6000
G1 X85.547 Y85.44 E-.03911
G1 X83.65 Y85.44 E-.72089
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.703 Y84.419 Z.96 F42000
G1 Z.56
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.429242
G1 F20156
M204 S6000
G1 X86.21 Y83.912 E.01415
G2 X86.359 Y83.193 I-.919 J-.565 E.01478
G1 X85.293 Y84.259 E.02973
G1 X84.722 Y84.259 E.01126
G1 X86.358 Y82.623 E.04565
G1 X86.358 Y82.052 E.01125
G1 X84.152 Y84.259 E.06156
G1 X83.581 Y84.259 E.01126
G1 X86.358 Y81.482 E.07748
G1 X86.358 Y80.911 E.01125
G1 X83.011 Y84.259 E.09339
G1 X82.44 Y84.259 E.01126
G1 X86.358 Y80.341 E.10931
G1 X86.358 Y79.77 E.01125
G1 X81.869 Y84.259 E.12522
G1 X81.299 Y84.259 E.01126
G1 X86.358 Y79.2 E.14114
G1 X86.357 Y78.629 E.01125
G1 X80.728 Y84.259 E.15705
G1 X80.157 Y84.259 E.01126
G1 X86.357 Y78.059 E.17297
G1 X86.357 Y77.488 E.01125
G1 X79.587 Y84.259 E.18888
G1 X79.016 Y84.259 E.01126
G1 X86.357 Y76.918 E.2048
G1 X86.357 Y76.347 E.01125
G1 X78.446 Y84.259 E.22071
G1 X77.875 Y84.259 E.01126
G1 X86.357 Y75.777 E.23663
G1 X86.356 Y75.207 E.01125
G1 X77.304 Y84.259 E.25255
G1 X76.734 Y84.259 E.01126
G1 X86.356 Y74.636 E.26846
G1 X86.356 Y74.066 E.01125
G1 X76.205 Y84.217 E.28321
G3 X75.857 Y83.994 I.476 J-1.127 E.00819
G1 X86.356 Y73.495 E.29291
G1 X86.356 Y72.925 E.01125
G1 X75.664 Y83.617 E.2983
G3 X75.641 Y83.069 I2.552 J-.379 E.01085
G1 X86.335 Y72.375 E.29833
G2 X86.138 Y72.001 I-1.059 J.318 E.00839
G1 X75.641 Y82.498 E.29284
G1 X75.641 Y81.927 E.01126
G1 X85.786 Y71.783 E.28302
G2 X85.255 Y71.743 I-.368 J1.349 E.01057
G1 X75.641 Y81.357 E.26821
M73 P14 R10
G1 X75.641 Y80.786 E.01126
G1 X84.684 Y71.743 E.25229
G1 X84.113 Y71.743 E.01126
G1 X75.641 Y80.215 E.23636
G1 X75.641 Y79.645 E.01126
G1 X83.543 Y71.743 E.22044
G1 X82.972 Y71.743 E.01126
G1 X75.641 Y79.074 E.20452
G1 X75.641 Y78.504 E.01126
G1 X82.401 Y71.744 E.1886
G1 X81.831 Y71.744 E.01126
G1 X75.641 Y77.933 E.17268
G1 X75.641 Y77.362 E.01126
G1 X81.26 Y71.744 E.15675
G1 X80.689 Y71.744 E.01126
G1 X75.641 Y76.792 E.14083
G1 X75.641 Y76.221 E.01126
G1 X80.119 Y71.744 E.12491
G1 X79.548 Y71.744 E.01126
G1 X75.641 Y75.65 E.10899
G1 X75.641 Y75.08 E.01126
G1 X78.977 Y71.744 E.09307
G1 X78.406 Y71.744 E.01126
G1 X75.641 Y74.509 E.07714
G1 X75.641 Y73.939 E.01126
G1 X77.836 Y71.744 E.06122
G1 X77.265 Y71.744 E.01126
G1 X75.641 Y73.368 E.0453
G1 X75.641 Y72.797 E.01126
G1 X76.694 Y71.744 E.02938
G2 X75.94 Y71.928 I-.146 J1.043 E.0157
G1 X75.482 Y72.386 E.01277
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X75.94 Y71.928 E-.24595
G1 X76.042 Y71.855 E-.04797
G1 X76.247 Y71.77 E-.08421
G1 X76.403 Y71.744 E-.06008
G1 X76.694 Y71.744 E-.1107
G1 X76.302 Y72.137 E-.21108
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 5/73
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.96 I-1.162 J.362 P1  F42000
G1 X86.784 Y105.762 Z.96
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19295
M204 S6000
G1 X86.711 Y105.689 E.00215
G3 X85.757 Y103.417 I2.305 J-2.305 E.05241
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.259 J.033 E.10483
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.033 J3.259 E.10483
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X87.029 Y105.968 I.033 J-3.259 E.04362
G1 X86.83 Y105.801 E.00539
M204 S10000
G1 X87.064 Y105.444 F42000
G1 F19295
M204 S6000
G1 X87.01 Y105.389 E.00158
G3 X86.181 Y103.41 I2.004 J-2.003 E.04565
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.287 Y105.632 I.024 J-2.833 E.03801
G1 X87.11 Y105.483 E.00482
M204 S250
G1 X87.322 Y105.126 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.299 Y105.101 E.00066
G3 X86.59 Y103.404 I1.713 J-1.713 E.03637
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.664 Y105.4 I.016 J-2.422 E.02726
G1 X87.369 Y105.164 E.00728
; WIPE_START
M204 S6000
G1 X87.299 Y105.101 E-.03574
G1 X86.996 Y104.739 E-.17935
G1 X86.773 Y104.322 E-.17956
G1 X86.636 Y103.87 E-.17951
G1 X86.59 Y103.404 E-.17821
G1 X86.59 Y103.383 E-.00764
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.08 F42000
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19295
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03181
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.963 J-.011 E.03181
G1 X103.778 Y88.695 E.41508
G3 X104.707 Y89.667 I-.033 J.961 E.03087
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.963 J.011 E.03181
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F19295
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.389 J-.002 E.04533
G1 X103.785 Y88.271 E.41537
G3 X105.131 Y89.66 I-.041 J1.387 E.0444
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.751 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X83.401 Y109.404 E.00678
G3 X81.96 Y107.647 I.358 J-1.764 E.04741
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.006 E.05425
G1 X103.792 Y87.861 E.38625
G3 X105.54 Y89.653 I-.05 J1.798 E.05338
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.811 Y109.44 E.38427
; WIPE_START
M204 S6000
G1 X83.401 Y109.404 E-.15643
G1 X83.065 Y109.304 E-.1333
G1 X82.757 Y109.139 E-.13267
G1 X82.484 Y108.916 E-.13395
G1 X82.263 Y108.646 E-.13264
G1 X82.175 Y108.481 E-.07102
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.08 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 5 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer5 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.716 Y106.538
G1 Z.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.485032
G1 F19295
M204 S6000
G2 X102.714 Y106.638 I-.029 J.049 E.00529
M204 S10000
G1 X103.114 Y104.83 F42000
; LINE_WIDTH: 0.419992
G1 F19295
M204 S6000
G3 X102.347 Y106.331 I-5.254 J-1.74 E.03262
G1 X101.703 Y107.015 E.01809
G1 X103.114 Y107.015 E.0272
G1 X103.114 Y104.89 E.04095
M204 S10000
G1 X102.98 Y103.622 F42000
; LINE_WIDTH: 0.525607
G1 F19295
M204 S6000
G1 X102.933 Y104.045 E.01038
; LINE_WIDTH: 0.557677
G1 X102.887 Y104.467 E.01105
; LINE_WIDTH: 0.554497
G1 X102.822 Y104.61 E.00407
; LINE_WIDTH: 0.516067
G1 X102.757 Y104.753 E.00377
; LINE_WIDTH: 0.477637
G1 X102.692 Y104.897 E.00348
; LINE_WIDTH: 0.420335
G3 X102.378 Y105.564 I-20.033 J-9.024 E.01423
G1 X102.064 Y106.049 E.01115
G1 X101.502 Y106.669 E.01614
G1 X100.803 Y107.194 E.01687
G1 X100.398 Y107.409 E.00884
G1 X103.509 Y107.409 E.06001
G1 X103.508 Y105.185 E.04289
; LINE_WIDTH: 0.439357
G1 X103.489 Y105.021 E.00336
; LINE_WIDTH: 0.478087
G1 X103.47 Y104.856 E.00367
; LINE_WIDTH: 0.516817
G1 X103.45 Y104.691 E.00399
; LINE_WIDTH: 0.548231
G1 X103.431 Y104.526 E.00424
G1 X103.459 Y103.83 E.01779
; LINE_WIDTH: 0.510288
G1 X103.462 Y93.674 E.2406
G1 X103.445 Y93.055 E.01467
; LINE_WIDTH: 0.523276
G1 X103.465 Y92.847 E.00508
; LINE_WIDTH: 0.481962
G1 X103.486 Y92.639 E.00466
; LINE_WIDTH: 0.420454
G1 X103.507 Y92.431 E.00403
G1 X103.506 Y89.893 E.04899
G1 X100.378 Y89.892 E.06037
G1 X100.802 Y90.105 E.00915
G1 X101.353 Y90.5 E.01309
G1 X101.793 Y90.921 E.01175
G1 X102.292 Y91.594 E.01616
G1 X102.671 Y92.381 E.01687
; LINE_WIDTH: 0.437595
G1 X102.773 Y92.671 E.00619
; LINE_WIDTH: 0.4728
G1 X102.876 Y92.961 E.00672
; LINE_WIDTH: 0.503785
G1 X102.902 Y93.025 E.00161
; LINE_WIDTH: 0.510308
G1 X102.929 Y93.089 E.00163
G1 X102.979 Y93.674 E.01391
G1 X102.98 Y103.562 E.23427
M204 S10000
G1 X103.109 Y92.431 F42000
; LINE_WIDTH: 0.419992
G1 F19295
M204 S6000
G2 X103.112 Y90.287 I-303.268 J-1.484 E.04133
G1 X101.709 Y90.287 E.02704
G1 X102.072 Y90.642 E.00979
G1 X102.612 Y91.364 E.01737
G1 X103.03 Y92.218 E.01833
G1 X103.088 Y92.375 E.00322
M204 S10000
G1 X102.71 Y90.668 F42000
; LINE_WIDTH: 0.494972
G1 F19295
M204 S6000
G2 X102.708 Y90.769 I-.029 J.05 E.00558
M204 S10000
G1 X102.681 Y89.104 F42000
; LINE_WIDTH: 0.419992
G1 F19295
M204 S6000
G1 X83.796 Y89.103 E.36401
G1 X83.536 Y89.153 E.0051
G2 X83.25 Y89.441 I.21 J.494 E.00802
G1 X83.203 Y89.758 E.00618
G1 X83.203 Y107.604 E.34399
G1 X83.253 Y107.864 E.0051
G2 X83.541 Y108.15 I.494 J-.21 E.00803
G1 X83.858 Y108.197 E.00618
G1 X103.704 Y108.197 E.38254
G1 X103.965 Y108.147 E.00511
G2 X104.25 Y107.859 I-.211 J-.494 E.00802
G1 X104.297 Y107.542 E.00618
G1 X104.295 Y89.65 E.34486
G2 X104.123 Y89.26 I-.807 J.121 E.00832
G1 X103.868 Y89.13 E.00552
G1 X102.74 Y89.105 E.02174
M204 S10000
G1 X98.525 Y89.488 F42000
; LINE_WIDTH: 0.412998
G1 F19295
M204 S6000
G1 X88.975 Y89.488 E.1808
G3 X87.476 Y89.497 I-.889 J-21.977 E.0284
G1 X83.833 Y89.497 E.06897
G1 X83.652 Y89.55 E.00357
G1 X83.597 Y89.758 E.00408
G1 X83.597 Y107.567 E.33718
G1 X83.65 Y107.748 E.00357
G1 X83.858 Y107.803 E.00408
G3 X88.774 Y107.811 I1.774 J423.497 E.09307
G1 X98.722 Y107.811 E.18836
; LINE_WIDTH: 0.419282
G1 X99.126 Y107.796 E.00777
; LINE_WIDTH: 0.420966
G3 X100.12 Y107.803 I.449 J6.576 E.01923
G1 X103.667 Y107.803 E.06853
G1 X103.848 Y107.75 E.00365
G1 X103.903 Y107.542 E.00417
G1 X103.9 Y89.66 E.34553
G1 X103.786 Y89.516 E.00355
G2 X99.132 Y89.501 I-3.27 J290.281 E.08994
; LINE_WIDTH: 0.413162
G1 X98.585 Y89.489 E.01037
M204 S10000
G1 X98.525 Y89.863 F42000
; LINE_WIDTH: 0.419877
G1 F19295
M204 S6000
G1 X99.087 Y89.895 E.01085
G1 X99.749 Y90.052 E.01312
G1 X100.472 Y90.368 E.01521
G1 X101.124 Y90.821 E.01528
G1 X101.514 Y91.2 E.01049
G1 X101.972 Y91.824 E.01491
G1 X102.312 Y92.544 E.01535
G3 X102.541 Y93.674 I-5.066 J1.615 E.02225
G1 X102.541 Y103.622 E.1917
G1 X102.422 Y104.391 E.01498
G3 X101.736 Y105.83 I-4.326 J-1.18 E.03089
G1 X101.214 Y106.4 E.01489
G1 X100.573 Y106.874 E.01536
G1 X100.084 Y107.124 E.01058
; LINE_WIDTH: 0.415997
G1 X99.59 Y107.313 E.01011
G1 X98.722 Y107.433 E.0167
G1 X88.774 Y107.433 E.18981
G1 X88.251 Y107.385 E.01002
G1 X87.506 Y107.159 E.01485
G1 X87.01 Y106.924 E.01047
G1 X86.376 Y106.479 E.01477
G1 X85.826 Y105.908 E.01513
G3 X85.101 Y104.485 I3.552 J-2.705 E.03065
G1 X84.959 Y103.623 E.01667
G1 X84.953 Y93.876 E.18597
G1 X84.997 Y93.318 E.01068
G1 X85.154 Y92.646 E.01317
G1 X85.471 Y91.922 E.01508
G1 X85.808 Y91.415 E.01163
G1 X86.292 Y90.894 E.01356
G1 X86.928 Y90.425 E.01507
G1 X87.478 Y90.152 E.01172
G1 X88.156 Y89.936 E.01357
G3 X88.975 Y89.863 I1.022 J6.823 E.01571
; LINE_WIDTH: 0.400547
G1 X98.465 Y89.863 E.17388
M204 S10000
G1 X84.843 Y90.664 F42000
; LINE_WIDTH: 0.487972
G1 F19295
M204 S6000
G2 X84.84 Y90.764 I-.029 J.049 E.00537
M204 S10000
G1 X84.386 Y92.467 F42000
; LINE_WIDTH: 0.419992
G1 F19295
M204 S6000
G1 X84.754 Y91.595 E.01824
G1 X85.158 Y90.969 E.01436
G1 X85.796 Y90.286 E.01802
G1 X84.385 Y90.285 E.02719
G1 X84.386 Y92.407 E.04089
M204 S10000
G1 X84.515 Y93.876 F42000
; LINE_WIDTH: 0.522252
G1 F19295
M204 S6000
G1 X84.556 Y93.215 E.01608
; LINE_WIDTH: 0.518192
G1 X84.627 Y92.996 E.00556
; LINE_WIDTH: 0.478912
G1 X84.698 Y92.776 E.00512
; LINE_WIDTH: 0.420466
G1 X84.77 Y92.556 E.00446
G1 X85.112 Y91.759 E.01676
G1 X85.483 Y91.192 E.01307
G1 X86.006 Y90.623 E.01492
G1 X86.698 Y90.105 E.01668
G1 X87.109 Y89.891 E.00894
G1 X83.991 Y89.891 E.06017
G1 X83.991 Y92.467 E.04971
; LINE_WIDTH: 0.439632
G1 X84.011 Y92.697 E.00467
; LINE_WIDTH: 0.478912
G1 X84.03 Y92.927 E.00512
; LINE_WIDTH: 0.50935
G1 X84.05 Y93.157 E.00546
G2 X84.035 Y93.876 I23.676 J.873 E.01701
G1 X84.036 Y103.623 E.23046
; LINE_WIDTH: 0.525877
G1 X84.052 Y104.067 E.01086
; LINE_WIDTH: 0.557887
G1 X84.068 Y104.511 E.01156
; LINE_WIDTH: 0.554655
G1 X84.049 Y104.68 E.00438
; LINE_WIDTH: 0.51618
G1 X84.03 Y104.848 E.00406
; LINE_WIDTH: 0.477705
G1 X84.01 Y105.017 E.00375
; LINE_WIDTH: 0.420367
G1 X83.991 Y105.185 E.00327
G1 X83.991 Y107.409 E.04291
G1 X87.102 Y107.409 E.06002
G1 X86.697 Y107.194 E.00884
G1 X86.147 Y106.799 E.01307
G1 X85.538 Y106.178 E.01678
G3 X84.922 Y105.157 I3.35 J-2.72 E.0231
; LINE_WIDTH: 0.438512
G1 X84.807 Y104.89 E.00585
; LINE_WIDTH: 0.475552
G1 X84.693 Y104.623 E.00638
; LINE_WIDTH: 0.514027
G1 X84.653 Y104.545 E.0021
; LINE_WIDTH: 0.547006
G1 X84.613 Y104.467 E.00224
G1 X84.53 Y103.79 E.01737
; LINE_WIDTH: 0.508371
G1 X84.515 Y93.936 E.23252
M204 S10000
G1 X85.347 Y93.876 F42000
; LINE_WIDTH: 0.419992
G1 F19295
M204 S6000
G1 X85.381 Y93.408 E.00905
G1 X85.537 Y92.735 E.0133
G1 X85.83 Y92.086 E.01373
G1 X86.133 Y91.638 E.01044
G1 X86.578 Y91.166 E.0125
G1 X87.158 Y90.746 E.0138
G1 X87.648 Y90.507 E.01051
G1 X88.27 Y90.321 E.01251
G3 X88.975 Y90.247 I1.012 J6.259 E.01368
G1 X98.525 Y90.247 E.18406
M73 P15 R10
G1 X98.996 Y90.281 E.00911
G1 X99.659 Y90.436 E.01313
G1 X100.31 Y90.727 E.01373
G1 X100.894 Y91.141 E.01381
G1 X101.256 Y91.503 E.00987
G1 X101.652 Y92.054 E.01306
G1 X101.953 Y92.707 E.01387
G3 X102.146 Y93.674 I-3.428 J1.19 E.01906
G1 X102.146 Y103.622 E.19176
G1 X102.033 Y104.327 E.01375
G3 X101.388 Y105.636 I-3.888 J-1.102 E.02829
G1 X100.926 Y106.131 E.01305
G1 X100.343 Y106.554 E.01388
G3 X98.722 Y107.046 I-1.923 J-3.413 E.03291
G1 X88.774 Y107.046 E.19176
G1 X88.272 Y106.979 E.00976
G1 X87.62 Y106.782 E.01313
G1 X87.157 Y106.554 E.00995
G1 X86.606 Y106.159 E.01306
G1 X86.114 Y105.639 E.01381
G3 X85.467 Y104.327 I3.222 J-2.404 E.02836
G1 X85.354 Y103.623 E.01374
G1 X85.347 Y93.936 E.18672
M204 S10000
G1 X84.385 Y104.829 F42000
; LINE_WIDTH: 0.419992
G1 F19295
M204 S6000
G1 X84.385 Y107.015 E.04212
G1 X85.797 Y107.015 E.02721
G1 X85.251 Y106.448 E.01517
G1 X84.854 Y105.887 E.01325
G3 X84.406 Y104.886 I3.707 J-2.26 E.0212
M204 S10000
G1 X84.841 Y106.538 F42000
; LINE_WIDTH: 0.484952
G1 F19295
M204 S6000
G2 X84.838 Y106.638 I-.029 J.049 E.00529
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X84.783 Y106.638 E-.1835
G1 X84.755 Y106.588 E-.19217
G1 X84.783 Y106.538 E-.19217
G1 X84.841 Y106.538 E-.19217
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X89.791 Y100.729 Z1.08 F42000
G1 X103.56 Y84.57 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X100.06 Y84.57 E.06747
G1 X100.06 Y85.06 E.00945
G1 X91.94 Y85.06 E.15652
G1 X91.94 Y73.93 E.21454
G1 X95.44 Y73.93 E.06747
G1 X95.44 Y73.44 E.00945
G1 X103.56 Y73.44 E.15652
G1 X103.56 Y84.51 E.21338
; WIPE_START
M204 S6000
G1 X101.56 Y84.544 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.928 Y84.563 Z1.08 F42000
G1 X91.107 Y84.57 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19295
M204 S6000
G1 X91.107 Y84.607 E.00076
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.51 E.20341
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F19295
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.999 Y83.978 Z1.08 F42000
G1 X104.393 Y83.797 Z1.08
G1 Z.68
G1 E.8 F1800
G1 F19295
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F19295
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
; WIPE_START
G1 F21000
G1 X104.018 Y82.221 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.14 Y85.44 Z1.08 F42000
G1 Z.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X92.36 Y73.87 E.02352
G1 X92.36 Y73.06 E.01561
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.14 Y84.63 E.02352
G1 X103.14 Y85.38 E.01446
M204 S10000
G1 X102.935 Y85.005 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.486522
G1 F19295
M204 S6000
G1 X100.265 Y85.005 E.06017
; WIPE_START
G1 F21000
G1 X102.265 Y85.005 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.287 Y78.491 Z1.08 F42000
G1 X95.235 Y73.495 Z1.08
G1 Z.68
G1 E.8 F1800
G1 F19295
M204 S6000
G1 X92.565 Y73.495 E.06017
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X94.565 Y73.495 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X89.747 Y79.415 Z1.08 F42000
G1 X85.521 Y84.607 Z1.08
G1 Z.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F19295
M204 S6000
G1 X76.467 Y84.607 E.1878
G3 X75.293 Y83.433 I-.01 J-1.164 E.03833
G1 X75.293 Y72.567 E.22539
G3 X76.467 Y71.393 I1.165 J-.009 E.03831
G1 X85.565 Y71.395 E.18873
G3 X86.707 Y72.567 I-.024 J1.165 E.03762
G1 X86.707 Y83.433 E.22539
G3 X85.581 Y84.606 I-1.164 J.01 E.03733
M204 S10000
G1 X85.521 Y85.031 F42000
G1 F19295
M204 S6000
G1 X76.46 Y85.031 E.18794
G3 X74.869 Y83.44 I-.001 J-1.59 E.05184
G1 X74.869 Y72.56 E.22568
G3 X76.46 Y70.969 I1.59 J-.001 E.05184
G1 X85.572 Y70.97 E.18901
G3 X87.131 Y72.56 I-.033 J1.591 E.05114
G1 X87.131 Y83.44 E.22568
G3 X85.581 Y85.03 I-1.59 J.001 E.051
M204 S250
G1 X85.586 Y85.436 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X85.547 Y85.44 E.00075
G1 X76.453 Y85.44 E.17528
G3 X74.46 Y83.447 I.007 J-2.001 E.0603
G1 X74.46 Y72.553 E.20997
G3 X76.453 Y70.56 I2.001 J.007 E.0603
G1 X85.579 Y70.561 E.1759
G3 X87.54 Y72.553 I-.042 J2.003 E.05964
G1 X87.54 Y83.447 E.20997
G3 X85.938 Y85.4 I-2.001 J-.007 E.0527
G1 X85.645 Y85.43 E.00567
; WIPE_START
M204 S6000
G1 X85.547 Y85.44 E-.03767
G1 X83.646 Y85.44 E-.72233
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.286 Y84.418 Z1.08 F42000
G1 Z.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.429472
G1 F19295
M204 S6000
G1 X75.839 Y83.971 E.01249
G1 X75.728 Y83.806 E.00393
G3 X75.641 Y83.202 I1.255 J-.488 E.01213
G1 X76.698 Y84.259 E.02949
G1 X77.269 Y84.259 E.01127
G1 X75.641 Y82.631 E.04543
G1 X75.641 Y82.06 E.01127
G1 X77.84 Y84.259 E.06137
G1 X78.411 Y84.259 E.01127
G1 X75.641 Y81.489 E.07731
G1 X75.641 Y80.918 E.01127
G1 X78.982 Y84.259 E.09324
G1 X79.553 Y84.259 E.01127
G1 X75.641 Y80.347 E.10918
G1 X75.641 Y79.777 E.01127
G1 X80.123 Y84.259 E.12512
G1 X80.694 Y84.259 E.01127
G1 X75.641 Y79.206 E.14106
G1 X75.641 Y78.635 E.01127
G1 X81.265 Y84.259 E.15699
G1 X81.836 Y84.259 E.01127
G1 X75.641 Y78.064 E.17293
G1 X75.641 Y77.493 E.01127
G1 X82.407 Y84.259 E.18887
G1 X82.978 Y84.259 E.01127
G1 X75.641 Y76.922 E.20481
G1 X75.641 Y76.351 E.01127
G1 X83.549 Y84.259 E.22075
G1 X84.12 Y84.259 E.01127
G1 X75.641 Y75.78 E.23668
G1 X75.641 Y75.209 E.01127
G1 X84.691 Y84.259 E.25262
G1 X85.262 Y84.259 E.01127
G1 X75.641 Y74.638 E.26856
G1 X75.641 Y74.067 E.01127
G1 X85.787 Y84.213 E.28321
G2 X86.14 Y83.995 I-.286 J-.858 E.00826
G1 X75.641 Y73.496 E.29306
G1 X75.641 Y72.925 E.01127
G1 X86.338 Y83.621 E.29858
G2 X86.359 Y83.071 I-3.019 J-.391 E.01088
G1 X75.666 Y72.379 E.29849
G3 X75.862 Y72.004 I.983 J.275 E.00841
G1 X86.358 Y82.5 E.29301
G1 X86.358 Y81.929 E.01127
G1 X76.212 Y71.783 E.28322
G3 X76.744 Y71.744 I.364 J1.318 E.01059
G1 X86.358 Y81.358 E.26837
G1 X86.358 Y80.787 E.01127
G1 X77.315 Y71.744 E.25243
G1 X77.886 Y71.744 E.01127
G1 X86.358 Y80.216 E.23649
G1 X86.358 Y79.645 E.01127
G1 X78.457 Y71.744 E.22055
G1 X79.028 Y71.744 E.01127
G1 X86.357 Y79.074 E.20462
G1 X86.357 Y78.503 E.01127
G1 X79.598 Y71.744 E.18868
G1 X80.169 Y71.744 E.01127
G1 X86.357 Y77.932 E.17274
M73 P16 R10
G1 X86.357 Y77.36 E.01127
G1 X80.74 Y71.743 E.1568
G1 X81.311 Y71.743 E.01127
G1 X86.357 Y76.789 E.14086
G1 X86.357 Y76.218 E.01127
G1 X81.882 Y71.743 E.12492
G1 X82.452 Y71.743 E.01127
G1 X86.357 Y75.647 E.10898
G1 X86.356 Y75.076 E.01127
G1 X83.023 Y71.743 E.09304
G1 X83.594 Y71.743 E.01127
G1 X86.356 Y74.505 E.0771
G1 X86.356 Y73.934 E.01127
G1 X84.165 Y71.743 E.06117
G1 X84.736 Y71.743 E.01127
G1 X86.356 Y73.363 E.04523
G1 X86.356 Y72.792 E.01127
G1 X85.307 Y71.742 E.02929
G1 X85.547 Y71.742 E.00475
G3 X86.088 Y71.953 I-.003 J.807 E.01172
G1 X86.515 Y72.38 E.01192
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X86.088 Y71.953 E-.22945
G1 X85.998 Y71.88 E-.04408
G1 X85.859 Y71.805 E-.06023
G1 X85.707 Y71.759 E-.06031
G1 X85.547 Y71.742 E-.06091
G1 X85.307 Y71.742 E-.09148
G1 X85.704 Y72.14 E-.21353
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 6/73
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.08 I-1.216 J.039 P1  F42000
G1 X86.77 Y105.748 Z1.08
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12517
M204 S6000
G1 X86.562 Y105.538 E.00614
G3 X85.97 Y104.554 I2.44 J-2.14 E.02394
G3 X85.757 Y103.417 I3.431 J-1.233 E.02409
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.246 J.02 E.10494
G1 X98.517 Y90.657 E.19777
G3 X100.017 Y91.035 I-.025 J3.265 E.03239
G3 X101.743 Y93.883 I-1.521 J2.869 E.07254
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.246 J-.02 E.10494
G1 X88.983 Y106.643 E.19777
G3 X86.862 Y105.838 I.02 J-3.246 E.04807
G1 X86.813 Y105.79 E.00141
M204 S10000
G1 X87.066 Y105.446 F42000
G1 F12517
M204 S6000
G1 X87.007 Y105.393 E.00164
G3 X86.181 Y103.41 I1.996 J-1.996 E.0457
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.822 J-.013 E.0914
G1 X88.99 Y106.219 E.19748
G3 X87.285 Y105.636 I.013 J-2.822 E.03805
G1 X87.111 Y105.485 E.00476
M204 S250
G1 X87.324 Y105.127 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.297 Y105.103 E.0007
G3 X86.59 Y103.404 I1.706 J-1.706 E.03641
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.006 J2.413 E.07281
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.413 J-.006 E.07281
G1 X88.996 Y105.81 E.18326
G3 X87.662 Y105.403 I.006 J-2.413 E.02729
G1 X87.371 Y105.165 E.00724
; WIPE_START
M204 S6000
G1 X87.297 Y105.103 E-.03667
G1 X86.996 Y104.739 E-.17948
G1 X86.773 Y104.322 E-.17955
G1 X86.636 Y103.87 E-.17951
G1 X86.59 Y103.404 E-.17821
G1 X86.59 Y103.386 E-.00658
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12517
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03182
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.963 J-.01 E.03181
G1 X103.787 Y88.695 E.41526
G3 X104.707 Y89.667 I-.041 J.96 E.0307
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.963 J.01 E.03181
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F12517
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.389 J-.002 E.04533
G1 X103.794 Y88.271 E.41555
G3 X105.131 Y89.66 I-.05 J1.386 E.04422
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.752 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X83.401 Y109.404 E.00679
G3 X81.96 Y107.647 I.358 J-1.764 E.04741
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.006 E.05425
G1 X103.8 Y87.862 E.38642
G3 X105.54 Y89.653 I-.058 J1.797 E.05321
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.812 Y109.44 E.38426
; WIPE_START
M204 S6000
G1 X83.401 Y109.404 E-.1566
G1 X83.065 Y109.304 E-.13331
G1 X82.756 Y109.138 E-.13331
G1 X82.484 Y108.916 E-.13333
G1 X82.263 Y108.646 E-.13257
G1 X82.175 Y108.482 E-.07088
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 6 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer6 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X83.317 Y108.05
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F12517
M204 S6000
G3 X83.156 Y107.616 I.64 J-.483 E.00974
G1 X83.156 Y106.393 E.02537
G3 X83.951 Y105.933 I3.997 J5.992 E.01906
G1 X84.231 Y105.478 E.01109
G1 X84.201 Y105.023 E.00946
G2 X83.156 Y103.193 I-3.147 J.584 E.04454
G1 X83.156 Y99.11 E.08469
G3 X83.951 Y98.65 I3.998 J5.993 E.01906
G1 X84.231 Y98.195 E.01109
G1 X84.201 Y97.74 E.00946
G2 X83.156 Y95.91 I-3.147 J.584 E.04454
G1 X83.156 Y91.827 E.08469
G3 X83.951 Y91.367 I3.998 J5.993 E.01906
G1 X84.231 Y90.912 E.01109
G1 X84.201 Y90.457 E.00946
G2 X83.595 Y89.082 I-4.069 J.974 E.03133
G3 X83.784 Y89.056 I.157 J.449 E.00398
G1 X85.29 Y89.056 E.03123
M204 S10000
G1 X86.128 Y91.719 F42000
G1 F12517
M204 S6000
G2 X85.452 Y93.259 I2.997 J2.233 E.03519
G1 X85.091 Y92.277 E.0217
G1 X85.061 Y91.822 E.00946
G1 X85.341 Y91.367 E.01109
G1 X86.129 Y90.912 E.01887
G2 X87.696 Y89.057 I-1.299 J-2.687 E.05188
G1 X90.854 Y89.057 E.0655
G3 X91.428 Y90.294 I-2.852 J2.073 E.02845
G1 X94.25 Y90.294 E.05854
G2 X94.979 Y89.057 I-1.874 J-1.939 E.03014
G1 X98.138 Y89.058 E.06552
G3 X98.715 Y90.306 I-2.877 J2.088 E.02871
G3 X100.595 Y90.97 I-.316 J3.888 E.04181
G2 X102.262 Y89.058 I-1.336 J-2.849 E.05417
G1 X103.766 Y89.058 E.03119
G3 X104.344 Y89.684 I-.049 J.625 E.01942
G1 X104.344 Y92.26 E.05344
G2 X103.299 Y94.098 I2.152 J2.439 E.04467
G1 X103.269 Y94.553 E.00946
G1 X103.549 Y95.009 E.01109
G1 X104.344 Y95.473 E.01909
G1 X104.344 Y99.543 E.08443
G2 X103.299 Y101.381 I2.152 J2.439 E.04467
G1 X103.269 Y101.836 E.00946
G1 X103.549 Y102.292 E.01109
G1 X104.344 Y102.756 E.01909
G1 X104.344 Y106.826 E.08443
G2 X103.445 Y108.244 I1.613 J2.016 E.03545
G1 X100.288 Y108.244 E.06549
G3 X99.657 Y106.844 I3.092 J-2.234 E.03207
G2 X98.977 Y106.976 I.001 J1.826 E.01447
G3 X96.898 Y107 I-1.163 J-10.54 E.04319
G2 X96.162 Y108.244 I1.874 J1.948 E.03035
G1 X93.005 Y108.244 E.06549
G3 X92.429 Y107 I2.857 J-2.079 E.02861
G1 X89.615 Y107 E.05836
G2 X88.879 Y108.244 I1.874 J1.948 E.03035
G1 X85.722 Y108.244 E.06549
G3 X85.091 Y106.844 I3.092 J-2.234 E.03207
G1 X85.061 Y106.388 E.00946
G1 X85.341 Y105.933 E.01109
G1 X86.078 Y105.507 E.01766
G3 X85.4 Y103.636 I2.869 J-2.099 E.04185
G1 X85.398 Y100.443 E.06623
G1 X85.091 Y99.56 E.01938
G1 X85.061 Y99.105 E.00946
G1 X85.397 Y98.618 E.01228
G1 X85.396 Y96.921 E.0352
; WIPE_START
G1 F24749.689
G1 X85.397 Y98.618 E-.64486
G1 X85.225 Y98.867 E-.11514
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X92.468 Y96.462 Z1.2 F42000
G1 X102.049 Y93.281 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F12517
M204 S6000
G3 X102.1 Y94.974 I-6.405 J1.039 E.03525
G1 X102.439 Y95.464 E.01235
G1 X102.409 Y95.919 E.00946
G1 X102.1 Y96.808 E.01952
G1 X102.1 Y102.258 E.11304
G1 X102.439 Y102.747 E.01235
G1 X102.409 Y103.202 E.00946
G1 X102.093 Y104.112 E.01999
G3 X101.223 Y105.755 I-5.173 J-1.688 E.03873
; OBJECT_ID: 66
; WIPE_START
G1 F24749.689
G1 X101.738 Y104.99 E-.35031
G1 X102.093 Y104.112 E-.35967
G1 X102.136 Y103.988 E-.05002
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X98.361 Y97.355 Z1.2 F42000
G1 X91.107 Y84.607 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F12517
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F12517
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z1.2 F42000
G1 X103.14 Y85.44 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P17 R10
G1 X104.393 Y83.797 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12517
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F12517
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.978 Y82.739 Z1.2 F42000
G1 X85.478 Y82.889 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F12517
M204 S6000
G1 X76.468 Y82.887 E.18689
G1 X76.347 Y82.859 E.00257
G1 X76.242 Y82.793 E.00258
G1 X75.293 Y81.906 E.02694
G1 X75.293 Y74.087 E.16218
G1 X76.247 Y73.202 E.02698
G1 X76.371 Y73.132 E.00294
G1 X76.522 Y73.111 E.00317
G1 X85.479 Y73.111 E.1858
G1 X85.629 Y73.132 E.00314
G1 X85.739 Y73.191 E.00258
G1 X86.707 Y74.095 E.02747
G1 X86.707 Y81.913 E.16218
G1 X85.753 Y82.798 E.02698
G1 X85.629 Y82.868 E.00294
G1 X85.537 Y82.881 E.00193
M204 S10000
G1 X85.485 Y83.313 F42000
G1 F12517
M204 S6000
G1 X76.515 Y83.313 E.18607
G3 X75.962 Y83.112 I-.016 J-.818 E.01248
G1 X74.869 Y82.089 E.03104
G1 X74.869 Y73.901 E.16984
G1 X75.968 Y72.882 E.03109
G3 X76.515 Y72.687 I.53 J.622 E.01231
G1 X85.486 Y72.687 E.18609
G3 X86.038 Y72.887 I.015 J.818 E.01246
G1 X87.131 Y73.911 E.03105
G1 X87.131 Y82.099 E.16984
G1 X86.032 Y83.118 E.03109
G3 X85.545 Y83.312 I-.53 J-.622 E.01107
; WIPE_START
G1 F21000
G1 X83.545 Y83.312 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.582 Y85.437 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X85.547 Y85.44 E.00068
G1 X76.453 Y85.44 E.17528
G3 X74.46 Y83.447 I.007 J-2.001 E.0603
G1 X74.46 Y72.553 E.20997
G3 X76.453 Y70.56 I2.001 J.007 E.0603
G1 X85.557 Y70.56 E.17548
G3 X87.54 Y72.553 I-.017 J2 E.06009
G1 X87.54 Y83.447 E.20997
G3 X85.938 Y85.4 I-2.001 J-.007 E.0527
G1 X85.641 Y85.43 E.00575
; WIPE_START
M204 S6000
G1 X85.547 Y85.44 E-.0362
G1 X83.642 Y85.44 E-.7238
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.308 Y83.679 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Top surface
G1 F12000
M204 S2000
G1 X85.779 Y85.208 E.04168
G1 X85.206 Y85.223
G1 X87.323 Y83.106 E.05771
G1 X87.323 Y82.549
G1 X84.649 Y85.223 E.0729
G1 X84.091 Y85.223
G1 X85.818 Y83.496 E.04708
G1 X85.212 Y83.545
G1 X83.534 Y85.223 E.04574
G1 X82.976 Y85.223
G1 X84.654 Y83.545 E.04574
G1 X84.097 Y83.545
G1 X82.419 Y85.223 E.04574
G1 X81.861 Y85.223
G1 X83.539 Y83.545 E.04574
G1 X82.982 Y83.545
G1 X81.304 Y85.223 E.04574
G1 X80.746 Y85.223
G1 X82.424 Y83.545 E.04574
G1 X81.867 Y83.545
G1 X80.188 Y85.223 E.04574
G1 X79.631 Y85.223
G1 X81.309 Y83.545 E.04574
G1 X80.751 Y83.545
G1 X79.073 Y85.223 E.04574
G1 X78.516 Y85.223
G1 X80.194 Y83.545 E.04574
G1 X79.636 Y83.545
G1 X77.958 Y85.223 E.04574
G1 X77.401 Y85.223
G1 X79.079 Y83.545 E.04574
G1 X78.521 Y83.545
G1 X76.843 Y85.223 E.04574
G1 X76.294 Y85.215
G1 X77.964 Y83.545 E.04553
G1 X77.406 Y83.545
G1 X75.838 Y85.113 E.04274
G1 X75.468 Y84.926
G1 X76.849 Y83.545 E.03764
G1 X76.309 Y83.528
G1 X75.166 Y84.671 E.03116
G1 X74.925 Y84.354
G1 X75.912 Y83.367 E.0269
G1 X75.615 Y83.106
G1 X74.755 Y83.966 E.02346
G1 X74.678 Y83.485
G1 X75.327 Y82.836 E.0177
G1 X75.039 Y82.567
G1 X74.677 Y82.929 E.00989
; WIPE_START
M204 S6000
G1 X75.039 Y82.567 E-.19488
G1 X75.327 Y82.836 E-.14989
G1 X74.678 Y83.485 E-.34887
G1 X74.706 Y83.658 E-.06636
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.299 Y82.888 Z1.2 F42000
G1 X87.343 Y82.376 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.170855
G1 F12517
M204 S6000
G1 X87.281 Y82.375 E.00044
; LINE_WIDTH: 0.140439
G1 X87.219 Y82.374 E.00035
; LINE_WIDTH: 0.102406
G1 X87.165 Y82.391 E.00021
G1 X86.206 Y83.315 E.00499
; LINE_WIDTH: 0.141672
G1 X86.048 Y83.449 E.00117
; LINE_WIDTH: 0.168572
G1 X85.99 Y83.492 E.00051
G3 X85.924 Y83.508 I-.041 J-.025 E.00053
G1 X85.806 Y83.485 E.00084
; WIPE_START
G1 F21000
G1 X85.924 Y83.508 E-.34305
G1 X85.957 Y83.514 E-.09696
G1 X85.99 Y83.492 E-.11302
G1 X86.048 Y83.449 E-.20697
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.204 Y84.088 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.077415
G1 F12517
M204 S6000
G1 X87.18 Y84.125 E.00011
; LINE_WIDTH: 0.102701
G1 X87.114 Y84.221 E.00044
; LINE_WIDTH: 0.140436
G1 X87.046 Y84.313 E.00064
; LINE_WIDTH: 0.181229
G3 X86.902 Y84.488 I-2.746 J-2.107 E.00172
; LINE_WIDTH: 0.206948
G3 X86.502 Y84.875 I-2.657 J-2.346 E.00494
; LINE_WIDTH: 0.170358
G1 X86.414 Y84.945 E.00079
; LINE_WIDTH: 0.138809
G1 X86.313 Y85.019 E.0007
; LINE_WIDTH: 0.0940303
G3 X86.188 Y85.104 I-1.352 J-1.86 E.0005
; WIPE_START
G1 F21000
G1 X86.313 Y85.019 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.359 Y82.525 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F12517
M204 S6000
G1 X77.662 Y82.525 E.0352
G2 X76.233 Y81.642 I-7.576 J10.666 E.03487
G1 X75.953 Y81.186 E.01109
G1 X75.983 Y80.731 E.00946
G3 X77.696 Y78.455 I3.14 J.581 E.06126
G1 X78.484 Y78 E.01887
G1 X78.764 Y77.545 E.01109
G1 X78.734 Y77.09 E.00946
G2 X77.021 Y74.814 I-3.14 J.581 E.06126
G1 X76.233 Y74.358 E.01887
G1 X75.979 Y73.946 E.01005
G3 X76.489 Y73.482 I1.233 J.844 E.01443
G1 X80.694 Y73.474 E.08722
G2 X82.126 Y74.358 I7.588 J-10.681 E.03493
G1 X82.406 Y74.814 E.01109
G1 X82.376 Y75.269 E.00946
G3 X80.662 Y77.545 I-3.14 J-.581 E.06126
G1 X79.874 Y78 E.01887
G1 X79.594 Y78.455 E.01109
G1 X79.624 Y78.91 E.00946
G2 X81.338 Y81.186 I3.14 J-.581 E.06126
G1 X82.126 Y81.642 E.01887
G1 X82.406 Y82.097 E.01109
G1 X82.378 Y82.525 E.00891
G1 X84.947 Y82.526 E.0533
G2 X83.516 Y81.642 I-7.587 J10.68 E.03493
G1 X83.236 Y81.186 E.01109
G1 X83.266 Y80.731 E.00946
G3 X84.98 Y78.455 I3.14 J.581 E.06126
G1 X85.767 Y78 E.01887
G1 X86.048 Y77.545 E.01109
G1 X86.017 Y77.09 E.00946
G2 X84.304 Y74.814 I-3.14 J.581 E.06126
G1 X83.516 Y74.358 E.01887
G1 X83.236 Y73.903 E.01109
G1 X83.264 Y73.474 E.00892
G1 X84.961 Y73.474 E.0352
; WIPE_START
G1 F24749.689
G1 X83.264 Y73.474 E-.64486
G1 X83.244 Y73.776 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.323 Y73.071 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
M204 S2000
G1 X86.96 Y73.433 E.00989
G1 X86.672 Y73.164
G1 X87.322 Y72.514 E.0177
G1 X87.245 Y72.034
G1 X86.385 Y72.894 E.02345
G1 X86.088 Y72.633
G1 X87.075 Y71.646 E.02691
G1 X86.834 Y71.329
G1 X85.691 Y72.472 E.03116
G1 X85.151 Y72.455
G1 X86.532 Y71.074 E.03764
G1 X86.162 Y70.887
G1 X84.594 Y72.455 E.04275
G1 X84.036 Y72.455
G1 X85.706 Y70.785 E.04553
G1 X85.156 Y70.777
G1 X83.479 Y72.455 E.04574
G1 X82.921 Y72.455
G1 X84.599 Y70.777 E.04574
G1 X84.041 Y70.777
G1 X82.363 Y72.455 E.04574
G1 X81.806 Y72.455
G1 X83.484 Y70.777 E.04574
G1 X82.926 Y70.777
G1 X81.248 Y72.455 E.04574
G1 X80.691 Y72.455
G1 X82.369 Y70.777 E.04574
G1 X81.811 Y70.777
G1 X80.133 Y72.455 E.04574
G1 X79.576 Y72.455
G1 X81.254 Y70.777 E.04574
G1 X80.696 Y70.777
G1 X79.018 Y72.455 E.04574
G1 X78.461 Y72.455
G1 X80.139 Y70.777 E.04574
M73 P18 R10
G1 X79.581 Y70.777
G1 X77.903 Y72.455 E.04574
G1 X77.346 Y72.455
G1 X79.024 Y70.777 E.04574
G1 X78.466 Y70.777
G1 X76.788 Y72.455 E.04574
G1 X76.182 Y72.504
G1 X77.909 Y70.777 E.04708
G1 X77.351 Y70.777
G1 X74.677 Y73.451 E.0729
G1 X74.677 Y72.894
G1 X76.794 Y70.777 E.0577
G1 X76.221 Y70.792
G1 X74.692 Y72.321 E.04168
M204 S10000
G1 X76.193 Y72.515 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.168369
G1 F12517
M204 S6000
G1 X76.076 Y72.492 E.00083
G2 X75.948 Y72.554 I.013 J.189 E.00101
; LINE_WIDTH: 0.141337
G1 X75.794 Y72.685 E.00114
; LINE_WIDTH: 0.115075
G1 X75.314 Y73.147 E.00291
; LINE_WIDTH: 0.0909062
G1 X74.835 Y73.609 E.00212
G1 X74.781 Y73.626 E.00018
; LINE_WIDTH: 0.140627
G1 X74.719 Y73.625 E.00035
; LINE_WIDTH: 0.170975
G1 X74.657 Y73.623 E.00044
; WIPE_START
G1 F21000
G1 X74.719 Y73.625 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.812 Y70.896 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.0775885
G1 F12517
M204 S6000
G1 X75.774 Y70.92 E.00011
; LINE_WIDTH: 0.1028
G1 X75.679 Y70.986 E.00044
; LINE_WIDTH: 0.140317
G1 X75.587 Y71.054 E.00064
; LINE_WIDTH: 0.181138
G2 X75.412 Y71.198 I2.113 J2.753 E.00171
; LINE_WIDTH: 0.20678
G2 X75.025 Y71.598 I2.387 J2.697 E.00493
; LINE_WIDTH: 0.17012
G1 X74.954 Y71.687 E.0008
; LINE_WIDTH: 0.140319
G1 X74.886 Y71.779 E.00064
; LINE_WIDTH: 0.102563
G1 X74.82 Y71.875 E.00044
; LINE_WIDTH: 0.0773668
G1 X74.796 Y71.912 E.00011
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X74.82 Y71.875 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 7/73
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I-1.148 J.405 P1  F42000
G1 X86.789 Y105.766 Z1.2
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10530
M204 S6000
G1 X86.711 Y105.689 E.00228
G3 X85.757 Y103.417 I2.305 J-2.305 E.05241
G1 X85.757 Y93.883 E.19777
G3 X87.855 Y90.867 I3.244 J.019 E.08102
G3 X88.983 Y90.657 I1.225 J3.44 E.0239
G1 X98.517 Y90.657 E.19777
G3 X100.026 Y91.039 I-.072 J3.448 E.03256
G3 X101.743 Y93.883 I-1.561 J2.884 E.07226
G1 X101.743 Y103.417 E.19777
G3 X101.536 Y104.539 I-3.656 J-.097 E.02376
G3 X98.517 Y106.643 I-3.038 J-1.141 E.08114
G1 X88.983 Y106.643 E.19777
G3 X87.029 Y105.968 I.033 J-3.259 E.04362
G1 X86.835 Y105.805 E.00526
M204 S10000
G1 X87.068 Y105.449 F42000
G1 F10530
M204 S6000
G1 X87.01 Y105.389 E.00173
G3 X86.181 Y103.41 I2.004 J-2.003 E.04565
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.822 J.013 E.0914
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.013 J2.822 E.0914
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.822 J-.013 E.0914
G1 X88.99 Y106.219 E.19748
G3 X87.218 Y105.577 I.024 J-2.833 E.03986
G1 X87.114 Y105.488 E.00283
M204 S250
G1 X87.326 Y105.129 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10530
M204 S5000
G1 X87.299 Y105.101 E.00075
G3 X86.59 Y103.404 I1.713 J-1.713 E.03637
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.413 J.006 E.07281
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.413 J-.006 E.07281
G1 X88.996 Y105.81 E.18326
G3 X87.664 Y105.4 I.016 J-2.422 E.02726
G1 X87.373 Y105.166 E.00719
; WIPE_START
G1 F12000
M204 S6000
G1 X87.299 Y105.101 E-.0374
G1 X86.996 Y104.739 E-.17937
G1 X86.773 Y104.322 E-.17949
G1 X86.636 Y103.87 E-.17954
G1 X86.59 Y103.404 E-.17821
G1 X86.59 Y103.388 E-.006
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.32 F42000
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10530
M204 S6000
G3 X82.793 Y107.633 I-.014 J-.959 E.03185
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.959 J-.014 E.03185
G1 X103.795 Y88.696 E.41544
G1 X103.813 Y88.696 E.00036
G3 X104.707 Y89.667 I-.065 J.956 E.0302
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.963 J.01 E.03182
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F10530
M204 S6000
G3 X82.369 Y107.64 I-.007 J-1.383 E.04538
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.383 J-.007 E.04538
G1 X103.802 Y88.271 E.41573
G3 X105.131 Y89.66 I-.059 J1.386 E.04403
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.752 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10530
M204 S5000
G1 X83.401 Y109.405 E.00681
G3 X81.96 Y107.647 I.352 J-1.758 E.04747
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.793 J-.001 E.05431
G1 X103.809 Y87.862 E.38659
G3 X105.54 Y89.653 I-.067 J1.797 E.05304
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.812 Y109.44 E.38425
; WIPE_START
G1 F12000
M204 S6000
G1 X83.401 Y109.405 E-.15689
G1 X83.065 Y109.304 E-.13329
G1 X82.756 Y109.138 E-.13333
G1 X82.484 Y108.916 E-.13332
G1 X82.262 Y108.644 E-.13331
G1 X82.175 Y108.482 E-.06986
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.32 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 7 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer7 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.427 Y103.842
G1 Z.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10530
M204 S6000
G2 X86.016 Y105.414 I3.575 J-.443 E.03515
G3 X84.646 Y105.723 I-1.137 J-1.853 E.02966
G1 X84.191 Y104.618 E.02479
G2 X83.156 Y103.237 I-3.253 J1.36 E.03615
G1 X83.156 Y106.505 E.06779
G3 X84.646 Y106.144 I1.265 J1.964 E.0324
G2 X85.557 Y108.061 I8.391 J-2.81 E.04413
G1 X85.784 Y108.244 E.00606
G1 X88.752 Y108.244 E.06155
G3 X89.619 Y107 I2.923 J1.115 E.03177
G1 X92.282 Y107 E.05523
G2 X92.84 Y108.061 I4.671 J-1.778 E.02492
G1 X93.068 Y108.244 E.00606
G1 X96.035 Y108.244 E.06155
G3 X96.903 Y107 I2.923 J1.115 E.03177
G1 X98.736 Y107 E.03803
G2 X99.506 Y106.857 I-.157 J-2.998 E.0163
G2 X100.123 Y108.061 I5.291 J-1.95 E.02812
G1 X100.351 Y108.244 E.00606
G1 X103.318 Y108.244 E.06155
G3 X104.344 Y106.879 I3.229 J1.359 E.03578
G1 X104.344 Y105.182 E.0352
M204 S10000
G1 X101.155 Y105.832 F42000
G1 F10530
M204 S6000
G2 X101.835 Y104.775 I-3.698 J-3.125 E.02615
G3 X102.854 Y102.502 I325.252 J144.462 E.05166
G3 X104.344 Y102.864 I.224 J2.325 E.0324
G1 X104.344 Y99.596 E.06779
G2 X103.764 Y100.164 I1.025 J1.624 E.01696
G2 X102.854 Y102.081 I7.482 J4.727 E.04413
G3 X102.1 Y102.024 I-.307 J-.959 E.01608
G1 X102.1 Y100.327 E.0352
M204 S10000
G1 X104.344 Y97.277 F42000
G1 F10530
M204 S6000
G1 X104.344 Y95.58 E.0352
G2 X102.854 Y95.219 I-1.265 J1.964 E.0324
G3 X102.1 Y96.857 I-7.159 J-2.302 E.0375
G1 X102.1 Y94.741 E.0439
G2 X102.854 Y94.798 I.447 J-.902 E.01608
G1 X103.309 Y93.693 E.02479
G3 X104.344 Y92.312 I3.254 J1.361 E.03615
G1 X104.344 Y89.684 E.05452
G2 X103.862 Y89.069 I-.607 J-.02 E.0176
G2 X102.389 Y89.058 I-.781 J6.147 E.03062
G3 X100.48 Y90.893 I-2.892 J-1.099 E.05676
G2 X98.866 Y90.316 I-2.133 J3.421 E.03581
G2 X98.302 Y89.239 I-4.741 J1.798 E.02528
G1 X98.131 Y89.058 E.00517
G1 X95.106 Y89.057 E.06274
G3 X94.245 Y90.294 I-2.904 J-1.105 E.03156
G1 X91.574 Y90.294 E.05541
G2 X91.019 Y89.239 I-4.643 J1.771 E.02478
G1 X90.847 Y89.057 E.00519
G1 X87.824 Y89.057 E.06271
G3 X85.557 Y91.05 I-3.198 J-1.351 E.06479
G3 X84.646 Y91.156 I-.586 J-1.071 E.01949
G2 X83.736 Y89.239 I-8.392 J2.81 E.04413
G1 X83.589 Y89.084 E.00443
G2 X83.156 Y89.684 I.168 J.578 E.01653
G1 X83.156 Y91.939 E.04678
G3 X84.646 Y91.577 I1.265 J1.964 E.0324
G2 X85.446 Y93.297 I7.517 J-2.45 E.03943
G3 X86.106 Y91.751 I3.749 J.688 E.03516
M204 S10000
G1 X83.156 Y94.257 F42000
G1 F10530
M204 S6000
G1 X83.156 Y95.954 E.0352
G3 X84.191 Y97.334 I-2.219 J2.741 E.03615
G1 X84.646 Y98.44 E.02479
G2 X85.397 Y98.384 I.306 J-.954 E.016
G1 X85.398 Y100.495 E.04379
G3 X84.646 Y98.861 I6.389 J-3.929 E.03741
G2 X83.156 Y99.222 I-.224 J2.326 E.0324
G1 X83.156 Y100.919 E.0352
; OBJECT_ID: 66
; WIPE_START
G1 F24749.689
G1 X83.156 Y99.222 E-.64486
G1 X83.439 Y99.113 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X87.006 Y92.365 Z1.32 F42000
G1 X91.107 Y84.607 Z1.32
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
G1 F10530
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F10530
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z1.32 F42000
G1 X103.14 Y85.44 Z1.32
G1 Z.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10530
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
M73 P19 R10
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z1.32 F42000
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10530
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F10530
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10530
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.988 Y83.047 Z1.32 F42000
G1 X85.49 Y83.621 Z1.32
G1 Z.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F10530
M204 S6000
G1 X76.51 Y83.621 E.18627
G3 X75.379 Y82.49 I-.009 J-1.122 E.03692
G1 X75.379 Y73.51 E.18627
G3 X76.51 Y72.379 I1.122 J-.009 E.03692
G1 X85.491 Y72.379 E.1863
G3 X86.621 Y73.51 I.009 J1.12 E.03691
G1 X86.621 Y82.49 E.18627
G3 X85.55 Y83.62 I-1.122 J.009 E.03568
M204 S10000
G1 X85.497 Y84.045 F42000
G1 F10530
M204 S6000
G1 X76.503 Y84.045 E.18656
G3 X74.955 Y82.497 I0 J-1.548 E.05044
G1 X74.955 Y73.503 E.18656
G3 X76.503 Y71.955 I1.548 J0 E.05044
G1 X85.498 Y71.955 E.18658
G3 X87.045 Y73.503 I.001 J1.546 E.05043
G1 X87.045 Y82.497 E.18656
G3 X85.557 Y84.044 I-1.548 J0 E.0492
M204 S250
G1 X85.504 Y84.454 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10530
M204 S5000
G1 X76.496 Y84.454 E.17362
G3 X74.546 Y82.504 I.008 J-1.959 E.059
G1 X74.546 Y73.496 E.17362
G3 X76.496 Y71.546 I1.959 J.008 E.059
G1 X85.505 Y71.546 E.17365
G3 X87.454 Y73.496 I-.008 J1.957 E.05899
G1 X87.454 Y82.504 E.17362
G3 X85.564 Y84.453 I-1.959 J-.008 E.05784
; WIPE_START
G1 F12000
M204 S6000
M73 P19 R9
G1 X83.564 Y84.453 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.224 Y82.288 Z1.32 F42000
G1 Z.92
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.401806
G1 F10530
M204 S6000
G3 X85.682 Y82.777 I-5.253 J-5.283 E.01344
G1 X85.462 Y82.843 E.00421
G1 X76.546 Y82.842 E.16394
G1 X76.299 Y82.772 E.00473
G3 X75.778 Y82.294 I21.709 J-24.179 E.013
G1 X75.836 Y82.774 E.00888
G1 X76.063 Y83.063 E.00676
G1 X76.344 Y83.191 E.00567
G1 X76.546 Y83.22 E.00376
G1 X85.462 Y83.22 E.16394
G1 X85.67 Y83.187 E.00388
G1 X85.97 Y83.035 E.00617
G1 X86.138 Y82.831 E.00486
G2 X86.223 Y82.348 I-.764 J-.383 E.00914
M204 S10000
G1 X86.2 Y81.775 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F10530
M204 S6000
G1 X85.484 Y82.438 E.02024
G3 X84.763 Y82.443 I-.378 J-2.573 E.015
G1 X84.642 Y82.36 E.00306
G2 X83.276 Y81.815 I-3.12 J5.844 E.03056
G1 X82.821 Y81.852 E.00947
G1 X82.578 Y82.443 E.01325
G1 X77.478 Y82.442 E.10578
G1 X77.358 Y82.36 E.00301
G2 X75.861 Y81.826 I-2.107 J3.545 E.03319
G1 X75.742 Y81.729 E.00318
G1 X75.742 Y80.935 E.01646
G3 X76.903 Y79.031 I4.952 J1.713 E.04662
G3 X78.724 Y78.174 I3.694 J5.485 E.04191
G1 X79.179 Y78.211 E.00947
G2 X80.09 Y80.128 I8.391 J-2.81 E.04413
G2 X81.91 Y81.325 I2.867 J-2.378 E.04587
G2 X82.821 Y81.431 I.586 J-1.071 E.01949
G3 X83.731 Y79.514 I8.392 J2.81 E.04413
G3 X85.552 Y78.317 I2.867 J2.377 E.04587
G3 X86.257 Y78.194 I.504 J.808 E.01521
G1 X86.256 Y77.289 E.01876
G2 X85.097 Y75.389 I-4.946 J1.714 E.04653
G2 X83.276 Y74.532 I-3.694 J5.485 E.04191
G1 X82.821 Y74.569 E.00947
G3 X81.91 Y76.486 I-8.391 J-2.81 E.04413
G3 X80.09 Y77.684 I-2.867 J-2.377 E.04587
G3 X79.179 Y77.79 I-.586 J-1.071 E.01949
G2 X78.269 Y75.872 I-8.392 J2.81 E.04413
G2 X76.448 Y74.675 I-2.867 J2.378 E.04587
G2 X75.742 Y74.552 I-.504 J.81 E.01524
G1 X75.742 Y74.267 E.00592
G1 X76.516 Y73.562 E.02172
G1 X80.878 Y73.557 E.09048
G1 X81 Y73.641 E.00307
G2 X82.366 Y74.185 I3.12 J-5.844 E.03056
G1 X82.821 Y74.148 E.00947
G1 X83.064 Y73.557 E.01326
G1 X84.761 Y73.557 E.0352
M204 S10000
G1 X86.227 Y73.475 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.400291
G1 F10530
M204 S6000
G1 X86.129 Y73.147 E.00627
G1 X85.925 Y72.93 E.00546
G2 X85.455 Y72.78 I-.473 J.667 E.00918
G1 X76.532 Y72.782 E.1634
G1 X76.294 Y72.821 E.00443
G1 X76.037 Y72.959 E.00534
G1 X75.861 Y73.169 E.00501
G2 X75.776 Y73.712 I.865 J.415 E.0102
G3 X76.318 Y73.221 I6.088 J6.183 E.01339
G1 X76.532 Y73.158 E.0041
G1 X85.457 Y73.157 E.16343
G1 X85.721 Y73.241 E.00507
G1 X86.227 Y73.723 E.0128
G1 X86.227 Y73.535 E.00344
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F16800
G1 X86.227 Y73.723 E-.07139
G1 X85.721 Y73.241 E-.26563
G1 X85.457 Y73.157 E-.10519
G1 X84.621 Y73.157 E-.3178
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 8/73
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.32 I-1.214 J.081 P1  F42000
G1 X86.791 Y105.769 Z1.32
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X86.707 Y105.693 E.00234
G3 X85.757 Y103.417 I2.296 J-2.296 E.05247
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.246 J.02 E.10494
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.033 J3.259 E.10483
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X87.026 Y105.972 I.02 J-3.246 E.04367
G1 X86.837 Y105.808 E.0052
M204 S10000
G1 X87.071 Y105.45 F42000
G1 F21000
M204 S6000
G1 X87.007 Y105.393 E.00177
G3 X86.181 Y103.41 I1.995 J-1.996 E.04571
G1 X86.181 Y93.89 E.19748
G3 X88.013 Y91.26 I2.82 J.012 E.0707
G3 X88.99 Y91.081 I1.057 J3.003 E.02068
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.284 Y105.636 I.013 J-2.822 E.03805
G1 X87.116 Y105.489 E.00463
M204 S250
G1 X87.328 Y105.13 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.297 Y105.103 E.00079
G3 X86.59 Y103.404 I1.706 J-1.706 E.03641
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.413 J.006 E.07281
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.662 Y105.403 I.006 J-2.413 E.02729
G1 X87.374 Y105.168 E.00716
; WIPE_START
M204 S6000
G1 X87.297 Y105.103 E-.03835
G1 X86.996 Y104.739 E-.17949
G1 X86.773 Y104.322 E-.17952
G1 X86.636 Y103.87 E-.17954
G1 X86.59 Y103.404 E-.17821
G1 X86.59 Y103.391 E-.0049
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.44 F42000
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03182
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.959 J-.014 E.03185
G1 X103.804 Y88.696 E.41562
G1 X103.813 Y88.696 E.00018
G3 X104.707 Y89.667 I-.069 J.96 E.03017
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.963 J.011 E.03182
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F21000
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.383 J-.007 E.04538
G1 X103.811 Y88.272 E.41591
G3 X105.131 Y89.66 I-.068 J1.386 E.04386
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.753 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X83.401 Y109.404 E.00681
G3 X81.96 Y107.647 I.359 J-1.763 E.04741
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.793 J-.001 E.05431
G1 X103.818 Y87.862 E.38675
G3 X105.54 Y89.653 I-.076 J1.797 E.05288
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.813 Y109.44 E.38424
; WIPE_START
M204 S6000
G1 X83.401 Y109.404 E-.157
G1 X83.065 Y109.304 E-.1332
G1 X82.756 Y109.138 E-.13339
G1 X82.484 Y108.916 E-.13336
G1 X82.262 Y108.644 E-.13328
G1 X82.175 Y108.482 E-.06978
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.44 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 8 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer8 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.033 Y103.866
G1 Z1.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F24749.689
M204 S6000
G2 X85.573 Y105.46 I4.458 J-.621 E.03513
G3 X85.101 Y105.479 I-.268 J-.782 E.00992
G1 X84.646 Y105.184 E.01126
G2 X83.551 Y103.588 I-6.804 J3.496 E.04026
G1 X83.551 Y106.462 E.05962
G3 X84.191 Y106.387 I.446 J1.039 E.01356
G1 X84.646 Y106.683 E.01126
G2 X85.38 Y107.849 I9.774 J-5.337 E.02861
G1 X88.891 Y107.849 E.07282
G3 X89.206 Y107.394 I1.182 J.482 E.01158
G1 X89.281 Y107.394 E.00155
G1 X89.643 Y107 E.0111
G1 X92.119 Y107 E.05136
G2 X92.84 Y108.106 I9.281 J-5.258 E.0274
G1 X93.036 Y108.244 E.00497
G1 X95.801 Y108.244 E.05736
G1 X96.026 Y108.065 E.00596
G3 X96.912 Y107 I2.843 J1.463 E.02897
G1 X97.241 Y107 E.00682
G1 X97.671 Y107.394 E.0121
G2 X99.554 Y107.253 I.538 J-5.442 E.03937
G2 X99.947 Y107.849 I5.005 J-2.868 E.01483
G1 X103.457 Y107.849 E.07282
G3 X103.949 Y107.229 I1.642 J.798 E.01655
G1 X103.949 Y105.532 E.0352
M204 S10000
M73 P20 R9
G1 X102.035 Y105.263 F42000
G1 F24749.689
M204 S6000
G2 X102.494 Y103.642 I-3.738 J-1.935 E.03519
G1 X102.854 Y103.041 E.01452
G3 X103.949 Y102.821 I.722 J.756 E.02445
G1 X103.949 Y99.946 E.05962
G2 X102.854 Y101.542 I5.709 J5.093 E.04026
G1 X102.494 Y101.776 E.0089
G1 X102.494 Y100.079 E.0352
M204 S10000
G1 X103.949 Y97.235 F42000
G1 F24749.689
M204 S6000
G1 X103.949 Y95.538 E.0352
G2 X103.309 Y95.463 I-.446 J1.038 E.01356
G1 X102.854 Y95.758 E.01126
G1 X102.494 Y96.359 E.01452
G1 X102.494 Y94.493 E.03871
G1 X102.854 Y94.259 E.0089
G3 X103.949 Y92.663 I6.805 J3.497 E.04026
G1 X103.949 Y89.69 E.06166
G1 X103.915 Y89.545 E.0031
G1 X103.785 Y89.458 E.00324
G2 X102.25 Y89.452 I-.793 J6.865 E.03191
G3 X100.842 Y90.661 I-2.293 J-1.246 E.03935
G2 X98.792 Y89.916 I-2.354 J3.284 E.04581
G2 X98.479 Y89.452 I-3.898 J2.295 E.01161
G1 X97.424 Y89.452 E.0219
G1 X96.994 Y89.058 E.0121
G1 X95.222 Y89.058 E.03676
G3 X94.237 Y90.294 I-4.58 J-2.641 E.03291
G1 X91.735 Y90.294 E.05188
G2 X90.872 Y89.057 I-6.177 J3.393 E.03134
G1 X88.971 Y89.057 E.03944
G1 X89.401 Y89.451 E.0121
G1 X87.684 Y89.451 E.0356
G3 X85.557 Y90.899 I-2.617 J-1.558 E.05512
G1 X85.101 Y90.913 E.00945
G1 X84.646 Y90.617 E.01126
G2 X83.912 Y89.451 I-9.778 J5.34 E.02861
G2 X83.551 Y89.702 I-.105 J.234 E.01097
G1 X83.551 Y91.896 E.0455
G3 X84.191 Y91.821 I.446 J1.039 E.01356
G1 X84.646 Y92.117 E.01126
G1 X85.101 Y92.877 E.01838
G2 X85 Y94.601 I9.869 J1.447 E.03589
M204 S10000
G1 X83.551 Y94.608 F42000
G1 F24749.689
M204 S6000
G1 X83.551 Y96.305 E.0352
G3 X84.646 Y97.901 I-5.709 J5.093 E.04026
G1 X85.002 Y98.132 E.0088
G1 X85.003 Y99.996 E.03867
G1 X84.646 Y99.4 E.01442
G1 X84.191 Y99.104 E.01126
G2 X83.551 Y99.179 I-.194 J1.114 E.01356
G1 X83.551 Y100.876 E.0352
; WIPE_START
G1 X83.551 Y99.179 E-.64486
G1 X83.852 Y99.144 E-.11515
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X88.094 Y105.489 Z1.44 F42000
G1 X89.115 Y107.016 Z1.44
G1 Z1.04
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.366115
;_EXTRUDE_SET_SPEED
M204 S6000
G1 X88.752 Y107.014 E.00603
G1 X88.182 Y106.924 E.00961
G1 X87.501 Y106.693 E.01197
G1 X86.815 Y106.279 E.01334
G1 X86.295 Y105.798 E.01178
G1 X85.87 Y105.224 E.01189
G3 X85.384 Y103.626 I3.646 J-1.981 E.02798
G1 X85.382 Y100.792 E.04716
G1 X85.299 Y100.406 E.00658
G1 X85.382 Y100.234 E.00318
G1 X85.378 Y93.873 E.10585
G1 X85.44 Y93.18 E.01157
G1 X85.573 Y92.725 E.00789
G1 X85.87 Y92.091 E.01166
G1 X86.265 Y91.536 E.01134
G1 X86.622 Y91.169 E.00851
G1 X87.175 Y90.772 E.01134
G1 X87.629 Y90.548 E.00842
G1 X88.265 Y90.354 E.01106
G3 X89.681 Y90.278 I1.065 J6.585 E.02365
; Slow Down End
M204 S10000
G1 X97.571 Y89.074 F42000
; Slow Down Start
; LINE_WIDTH: 0.365803
G1 F1800;_EXTRUDE_SET_SPEED
M204 S6000
G1 X103.742 Y89.074 E.1026
G1 X104.001 Y89.142 E.00445
G1 X104.207 Y89.314 E.00446
G1 X104.319 Y89.604 E.00518
G1 X104.328 Y107.608 E.29932
G1 X104.254 Y107.911 E.0052
G1 X104.038 Y108.139 E.00521
G1 X103.708 Y108.228 E.00569
G1 X99.198 Y108.228 E.07497
; Slow Down End
; WIPE_START
G1 X101.198 Y108.228 E-.76
; WIPE_END
G1 E-.04
M204 S10000
G1 X102.098 Y103.704 Z1.44 F42000
G1 Z1.04
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.366265
;_EXTRUDE_SET_SPEED
M204 S6000
G1 X102.043 Y104.115 E.00691
G1 X101.885 Y104.675 E.00969
G3 X100.878 Y106.131 I-3.69 J-1.476 E.02971
G1 X100.3 Y106.542 E.01182
G1 X99.68 Y106.824 E.01134
G3 X98.726 Y107.016 I-1.173 J-3.373 E.01624
G1 X97.878 Y107.016 E.01412
; Slow Down End
M204 S10000
G1 X88.991 Y108.228 F42000
; Slow Down Start
; LINE_WIDTH: 0.365752
G1 F1800;_EXTRUDE_SET_SPEED
M204 S6000
G1 X83.792 Y108.228 E.08642
G1 X83.53 Y108.18 E.00444
G1 X83.275 Y107.962 E.00556
G1 X83.172 Y107.608 E.00614
G1 X83.172 Y89.692 E.29781
G1 X83.22 Y89.429 E.00444
G1 X83.438 Y89.175 E.00556
G1 X83.792 Y89.072 E.00614
G1 X88.368 Y89.073 E.07607
; Slow Down End
M204 S10000
G1 X98.442 Y90.273 F42000
G1 F16800
M204 S6000
G1 X98.961 Y90.307 E.00865
G1 X99.652 Y90.467 E.01178
G1 X100.287 Y90.75 E.01156
G1 X100.872 Y91.172 E.01199
G1 X101.363 Y91.682 E.01178
G3 X102.05 Y93.178 I-3.399 J2.465 E.02753
G1 X102.116 Y93.674 E.00833
G1 X102.116 Y95.833 E.0359
G1 X102.2 Y96.237 E.00686
G1 X102.116 Y96.395 E.00297
G1 X102.116 Y102.363 E.0992
; OBJECT_ID: 66
; WIPE_START
G1 X102.116 Y100.363 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X97.744 Y94.106 Z1.44 F42000
G1 X91.107 Y84.607 Z1.44
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F21000
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z1.44 F42000
G1 X103.14 Y85.44 Z1.44
G1 Z1.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z1.44 F42000
G1 Z1.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F21000
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.988 Y83.041 Z1.44 F42000
G1 X85.483 Y83.607 Z1.44
G1 Z1.04
M73 P21 R9
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X76.517 Y83.607 E.186
G3 X75.393 Y82.483 I-.008 J-1.115 E.0367
G1 X75.393 Y73.517 E.186
G3 X76.517 Y72.393 I1.115 J-.009 E.0367
G1 X85.486 Y72.393 E.18606
G3 X86.607 Y73.517 I.007 J1.114 E.03665
G1 X86.607 Y82.483 E.186
G3 X85.543 Y83.606 I-1.115 J.009 E.03546
M204 S10000
G1 X85.49 Y84.032 F42000
G1 F21000
M204 S6000
G1 X76.51 Y84.032 E.18628
G3 X74.968 Y82.49 I0 J-1.541 E.05022
G1 X74.968 Y73.51 E.18628
G3 X76.51 Y71.968 I1.541 J0 E.05022
G1 X85.494 Y71.969 E.18635
G3 X87.032 Y73.51 I-.002 J1.54 E.05016
G1 X87.032 Y82.49 E.18628
G3 X85.55 Y84.03 I-1.541 J0 E.04898
M204 S250
G1 X85.497 Y84.441 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.503 Y84.441 E.17336
G3 X74.559 Y82.497 I.009 J-1.952 E.05879
G1 X74.559 Y73.503 E.17336
G3 X76.503 Y71.559 I1.952 J.008 E.05879
G1 X85.5 Y71.559 E.17343
G3 X87.441 Y73.503 I-.01 J1.951 E.05874
G1 X87.441 Y82.497 E.17336
G3 X85.557 Y84.44 I-1.952 J-.008 E.05764
; WIPE_START
M204 S6000
G1 X83.557 Y84.44 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.216 Y82.29 Z1.44 F42000
G1 Z1.04
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.39481
G1 F16800
M204 S6000
G3 X85.681 Y82.776 I-7.634 J-7.861 E.01304
G1 X85.456 Y82.84 E.00422
G1 X76.552 Y82.839 E.16066
G1 X76.301 Y82.769 E.00471
G3 X75.787 Y82.297 I22.112 J-24.601 E.01258
G1 X75.843 Y82.76 E.00841
G1 X76.074 Y83.056 E.00677
G1 X76.347 Y83.181 E.00542
G1 X76.552 Y83.21 E.00375
G1 X85.456 Y83.21 E.16066
G1 X85.661 Y83.18 E.00374
G1 X85.914 Y83.06 E.00505
G1 X86.132 Y82.818 E.00588
G2 X86.215 Y82.35 I-.742 J-.373 E.0087
M204 S10000
G1 X86.15 Y81.821 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F24749.689
M204 S6000
G1 X85.484 Y82.438 E.01884
G3 X83.731 Y82.109 I-.319 J-3.135 E.0375
G1 X83.276 Y82.096 E.00945
G1 X82.79 Y82.443 E.01239
G1 X77.41 Y82.442 E.1116
G1 X76.448 Y82.109 E.02111
G1 X76.154 Y82.101 E.00611
G1 X75.755 Y81.741 E.01112
G1 X75.755 Y80.528 E.02516
G3 X76.903 Y79.044 I5.007 J2.686 E.0391
G3 X78.724 Y78.454 I2.025 J3.145 E.04015
G1 X79.179 Y78.75 E.01126
G2 X80.545 Y80.598 I5.897 J-2.93 E.04791
G2 X82.366 Y81.188 I2.025 J-3.145 E.04015
G1 X82.821 Y80.892 E.01126
G3 X84.186 Y79.044 I5.898 J2.93 E.04791
G3 X86.007 Y78.454 I2.025 J3.145 E.04015
G1 X86.243 Y78.607 E.00584
G1 X86.243 Y76.884 E.03575
G2 X85.097 Y75.403 I-5 J2.685 E.03902
G2 X83.276 Y74.813 I-2.025 J3.145 E.04015
G1 X82.821 Y75.108 E.01126
G3 X81.455 Y76.956 I-5.897 J-2.93 E.04791
G3 X79.634 Y77.546 I-2.025 J-3.145 E.04015
G1 X79.179 Y77.25 E.01126
G2 X77.814 Y75.403 I-5.898 J2.93 E.04791
G2 X75.993 Y74.813 I-2.025 J3.145 E.04015
G1 X75.755 Y74.967 E.00587
G1 X75.755 Y74.255 E.01477
G1 X76.516 Y73.562 E.02134
G1 X80.946 Y73.557 E.09189
G1 X81.91 Y73.891 E.02117
G1 X82.366 Y73.904 E.00945
G1 X82.852 Y73.557 E.0124
G1 X84.549 Y73.557 E.0352
M204 S10000
G1 X86.217 Y73.482 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.393361
G1 F16800
M204 S6000
G1 X86.119 Y73.154 E.00615
G1 X85.918 Y72.94 E.00528
G2 X85.448 Y72.79 I-.47 J.662 E.009
G1 X76.532 Y72.792 E.16025
G1 X76.302 Y72.83 E.0042
G1 X76.046 Y72.967 E.00522
G1 X75.871 Y73.176 E.00491
G2 X75.785 Y73.708 I.846 J.409 E.00982
G3 X76.319 Y73.225 I6.273 J6.39 E.01295
G1 X76.532 Y73.161 E.004
G1 X85.448 Y73.16 E.16025
G1 X85.718 Y73.244 E.00508
G1 X86.218 Y73.719 E.01239
G1 X86.217 Y73.542 E.00319
M106 S255
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F16800
G1 X86.218 Y73.719 E-.06748
G1 X85.718 Y73.244 E-.262
G1 X85.448 Y73.16 E-.10743
G1 X84.598 Y73.16 E-.3231
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M106 S196.35
M625
; layer num/total_layer_count: 9/73
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
M106 S255
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
M204 S10000
G17
G3 Z1.44 I-1.214 J.082 P1  F42000
G1 X86.79 Y105.769 Z1.44
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X86.707 Y105.693 E.00234
G3 X85.757 Y103.417 I2.295 J-2.295 E.05247
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.259 J.033 E.10483
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.02 J3.246 E.10494
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.253 J-.027 E.10488
G1 X88.983 Y106.643 E.19777
G3 X86.93 Y105.897 I.019 J-3.245 E.0462
G1 X86.834 Y105.81 E.00268
M204 S10000
G1 X87.074 Y105.455 F42000
G1 F21000
M204 S6000
G1 X87.009 Y105.391 E.00188
G3 X86.181 Y103.41 I2 J-1.999 E.04568
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.013 J2.822 E.0914
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.821 J-.012 E.09141
G1 X88.99 Y106.219 E.19748
G3 X87.201 Y105.566 I.019 J-2.828 E.04028
G1 X87.119 Y105.494 E.00228
M204 S250
G1 X87.329 Y105.132 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.297 Y105.103 E.00083
G3 X86.59 Y103.404 I1.706 J-1.706 E.03641
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.006 J2.413 E.07281
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.417 J-.011 E.07277
G1 X88.996 Y105.81 E.18326
G3 X87.662 Y105.403 I.006 J-2.413 E.02729
G1 X87.376 Y105.17 E.00711
; WIPE_START
M204 S6000
G1 X87.297 Y105.103 E-.03923
G1 X86.996 Y104.739 E-.17948
G1 X86.773 Y104.322 E-.17952
G1 X86.636 Y103.87 E-.17954
G1 X86.59 Y103.404 E-.1782
G1 X86.59 Y103.393 E-.00402
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.56 F42000
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G3 X82.793 Y107.633 I-.006 J-.967 E.03177
G1 X82.793 Y89.667 E.37267
G3 X83.767 Y88.693 I.967 J-.006 E.03177
G1 X103.771 Y88.695 E.41494
G3 X104.707 Y89.667 I-.022 J.957 E.03105
G1 X104.707 Y107.633 E.37267
G3 X103.733 Y108.607 I-.967 J.006 E.03177
G1 X83.827 Y108.607 E.41291
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F21000
M204 S6000
G3 X82.369 Y107.64 I.003 J-1.394 E.04529
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.394 J.003 E.04529
G1 X103.795 Y88.271 E.41557
G3 X105.131 Y89.66 I-.046 J1.381 E.04423
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.394 J-.003 E.04529
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.753 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X83.401 Y109.403 E.00682
G3 X81.96 Y107.647 I.364 J-1.768 E.04737
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.805 J.012 E.05421
G1 X103.818 Y87.862 E.38676
G3 X105.54 Y89.653 I-.069 J1.79 E.05293
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.805 J-.012 E.05421
G1 X83.813 Y109.44 E.38423
; WIPE_START
M204 S6000
G1 X83.401 Y109.403 E-.15714
G1 X83.065 Y109.304 E-.13321
G1 X82.756 Y109.138 E-.1333
G1 X82.483 Y108.914 E-.13409
G1 X82.261 Y108.643 E-.13326
G1 X82.175 Y108.483 E-.06899
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.56 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M106 S196.35
M625
; object ids of layer 9 start: 66,77,88
M624 BwAAAAAAAAA=
M106 S255
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer9 end: 66,77,88
M106 S196.35
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
G1 X82.975 Y107.719
G1 Z1.16
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40687
; LAYER_HEIGHT: 0.4

M204 S6000
G2 X83.43 Y108.132 I4.421 J-4.411 E.03253
G1 X83.463 Y108.15 E.00202
G2 X83.605 Y108.208 I.217 J-.328 E.00817
G2 X84.209 Y108.231 I.384 J-2.134 E.03209
G1 X83.169 Y107.277 E.07475
G1 X83.169 Y106.656 E.03285
G1 X84.884 Y108.231 E.12333
G1 X85.56 Y108.231 E.03579
G1 X83.169 Y106.036 E.17191
G1 X83.169 Y105.416 E.03285
G1 X86.235 Y108.231 E.22049
G1 X86.911 Y108.231 E.03579
G1 X83.169 Y104.796 E.26907
G1 X83.169 Y104.176 E.03285
G1 X87.586 Y108.231 E.31766
G1 X88.262 Y108.231 E.03579
G1 X83.169 Y103.555 E.36624
G1 X83.169 Y102.935 E.03285
G1 X88.932 Y108.226 E.41444
G1 X88.943 Y108.076 E.00796
G1 X89.137 Y107.794 E.01815
G1 X88.187 Y106.922 E.0683
G2 X88.985 Y107.034 I.968 J-3.996 E.04274
G1 X89.152 Y107.188 E.01203
M106 S196.35
M106 S255
; WIPE_START
G1 X88.985 Y107.034 E-.0863
G1 X88.522 Y106.988 E-.17691
G1 X88.187 Y106.922 E-.12955
G1 X88.899 Y107.575 E-.36724
; WIPE_END
G1 E-.04
M204 S10000
G1 X83.277 Y102.414 Z1.56 F42000
G1 X82.967 Y102.129 Z1.56
G1 Z1.16
G1 E.8 F1800

M204 S6000
G1 X85.566 Y104.515 E.18691
G3 X85.401 Y103.744 I2.504 J-.937 E.04191
G1 X83.169 Y101.695 E.16053
G1 X83.169 Y101.075 E.03285
G1 X85.387 Y103.111 E.15949
G1 X85.387 Y102.49 E.03287
G1 X83.169 Y100.454 E.15946
G1 X83.169 Y99.834 E.03285
G1 X85.386 Y101.87 E.15943
M73 P22 R9
G1 X85.386 Y101.249 E.03287
G1 X83.169 Y99.214 E.1594
G1 X83.169 Y98.594 E.03285
G1 X85.124 Y100.388 E.14055
G1 X85.059 Y100.254 E.00789
G1 X85.385 Y100.173 E.01779
G1 X85.385 Y100.008 E.00873
G1 X83.169 Y97.974 E.15934
G1 X83.169 Y97.353 E.03285
G1 X85.384 Y99.387 E.15931
G1 X85.384 Y98.767 E.03287
G1 X83.169 Y96.733 E.15928
G1 X83.169 Y96.113 E.03285
G1 X85.384 Y98.146 E.15925
G1 X85.383 Y97.526 E.03287
G1 X83.169 Y95.493 E.15922
G1 X83.169 Y94.873 E.03285
G1 X85.383 Y96.905 E.15919
G1 X85.382 Y96.284 E.03287
G1 X83.169 Y94.252 E.15916
G1 X83.169 Y93.632 E.03285
G1 X85.382 Y95.664 E.15914
G1 X85.382 Y95.043 E.03287
G1 X83.169 Y93.012 E.15911
G1 X83.169 Y92.392 E.03285
G1 X85.381 Y94.423 E.15908
G3 X85.385 Y93.806 I4.552 J-.279 E.03269
G1 X83.169 Y91.772 E.15936
G1 X83.169 Y91.151 E.03285
G1 X85.385 Y93.186 E.15937
G1 X85.571 Y92.737 E.02576
G1 X83.169 Y90.531 E.17276
G1 X83.169 Y89.911 E.03285
G1 X85.759 Y92.289 E.18624
G1 X85.812 Y92.189 E.006
G3 X85.993 Y91.884 I2.407 J1.223 E.0188
G1 X83.25 Y89.365 E.19731
G3 X83.623 Y89.087 I.577 J.386 E.02512
G1 X86.273 Y91.52 E.19057
G1 X86.595 Y91.196 E.02422
G1 X84.279 Y89.069 E.16658
G1 X84.954 Y89.069 E.03579
G1 X86.965 Y90.915 E.14458
G3 X87.376 Y90.673 I1.126 J1.442 E.02537
G1 X85.63 Y89.069 E.12559
G1 X86.306 Y89.069 E.03579
G1 X87.835 Y90.473 E.10995
G3 X88.363 Y90.338 I2.677 J9.402 E.02891
G1 X86.981 Y89.069 E.0994
G1 X87.657 Y89.069 E.03579
G1 X88.976 Y90.281 E.0949
G1 X89.652 Y90.281 E.03579
G1 X88.112 Y88.867 E.11076
M106 S196.35
M106 S255
M204 S10000
G1 X97.066 Y89.104 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
; LAYER_HEIGHT: 0.12
G1 F16800
M204 S6000
G1 X88.999 Y89.103 E.15551
G1 X90.245 Y90.247 E.03261
G1 X97.992 Y90.247 E.14933
G3 X98.134 Y90.084 I.867 J.607 E.00418
G1 X97.11 Y89.144 E.02678
M204 S10000
G1 X97.325 Y89.863 F42000
; LINE_WIDTH: 0.400602
G1 F16800
M204 S6000
G1 X96.916 Y89.488 E.01016
G1 X89.986 Y89.488 E.12701
G1 X90.395 Y89.863 E.01016
G1 X97.265 Y89.863 E.12591
M204 S10000
G1 X97.683 Y88.867 F42000
; FEATURE: Bridge
; LINE_WIDTH: 0.40573
; LAYER_HEIGHT: 0.4
G1 F1800
M204 S6000
G1 X99.669 Y90.691 E.14202
M106 S196.35
M106 S255
M204 S10000
G1 X98.357 Y88.868 F42000
G1 F1800
M204 S6000
G1 X104.329 Y94.35 E.42704
G1 X104.329 Y93.731 E.03259
G1 X99.252 Y89.07 E.36307
G1 X99.926 Y89.07 E.0355
G1 X104.329 Y93.112 E.31487
G1 X104.329 Y92.494 E.03259
G1 X100.599 Y89.07 E.26667
G1 X101.273 Y89.07 E.0355
G1 X104.329 Y91.875 E.21848
G1 X104.329 Y91.256 E.03259
G1 X101.947 Y89.07 E.17028
G1 X102.621 Y89.07 E.0355
G1 X104.328 Y90.638 E.12208
G1 X104.328 Y90.019 E.03259
G1 X103.295 Y89.07 E.07388
G3 X103.861 Y89.082 I.227 J2.676 E.02989
G3 X104.13 Y89.218 I-.132 J.595 E.01601
G1 X104.528 Y89.583 E.02845
M106 S196.35
M106 S255
M204 S10000
G1 X101.594 Y92.458 F42000
G1 F1800
M204 S6000
G1 X104.329 Y94.969 E.19559
G1 X104.329 Y95.587 E.03259
G1 X102.096 Y93.537 E.15968
G1 X102.113 Y93.663 E.00669
G1 X102.113 Y94.171 E.02676
G1 X104.329 Y96.206 E.1585
G1 X104.329 Y96.825 E.03259
G1 X102.113 Y94.79 E.15851
G1 X102.113 Y95.409 E.03259
G1 X104.329 Y97.444 E.15851
G1 X104.33 Y98.062 E.03259
G1 X102.401 Y96.292 E.13788
G1 X102.442 Y96.376 E.00489
G1 X102.113 Y96.456 E.01783
G1 X102.113 Y96.646 E.01
G1 X104.33 Y98.681 E.15853
G1 X104.33 Y99.3 E.03259
G1 X102.113 Y97.265 E.15853
G1 X102.113 Y97.883 E.03259
G1 X104.33 Y99.919 E.15854
G1 X104.33 Y100.537 E.03259
G1 X102.113 Y98.502 E.15855
G1 X102.113 Y99.12 E.03259
G1 X104.33 Y101.156 E.15855
G1 X104.33 Y101.775 E.03259
G1 X102.113 Y99.739 E.15856
G1 X102.113 Y100.358 E.03259
G1 X104.33 Y102.393 E.15857
G1 X104.33 Y103.012 E.03259
G1 X102.113 Y100.976 E.15857
G1 X102.113 Y101.595 E.03259
G1 X104.33 Y103.631 E.15858
G1 X104.33 Y104.25 E.03259
G1 X102.113 Y102.214 E.15858
G1 X102.113 Y102.302 E.00466
G1 X102.758 Y103.425 E.06821
G1 X104.33 Y104.868 E.11245
G1 X104.331 Y105.487 E.03259
G1 X102.391 Y103.706 E.13871
G1 X102.111 Y103.764 E.01504
M73 P23 R9
G1 X102.06 Y104.021 E.01383
G1 X104.331 Y106.106 E.16238
G1 X104.331 Y106.725 E.03259
G1 X101.934 Y104.524 E.17141
G3 X101.751 Y104.975 I-2.643 J-.806 E.02567
G1 X104.331 Y107.343 E.18446
G3 X104.267 Y107.904 I-1.299 J.136 E.02994
G1 X101.521 Y105.382 E.19641
G3 X101.25 Y105.752 I-2.013 J-1.188 E.0242
G1 X103.917 Y108.201 E.19074
G3 X103.276 Y108.231 I-.421 J-2.141 E.03394
G1 X100.931 Y106.078 E.16769
G3 X100.568 Y106.363 I-1.852 J-1.984 E.02436
G1 X102.602 Y108.231 E.14547
G1 X101.928 Y108.231 E.0355
G1 X100.165 Y106.612 E.12608
G3 X100.009 Y106.685 I-.448 J-.754 E.00907
G1 X99.707 Y106.81 E.01724
G1 X101.254 Y108.231 E.11065
G1 X100.581 Y108.231 E.0355
G1 X99.189 Y106.953 E.09952
G3 X98.58 Y107.013 I-.531 J-2.282 E.03233
G1 X99.907 Y108.231 E.09489
G1 X99.233 Y108.231 E.0355
G1 X97.685 Y106.81 E.11066
M106 S196.35
M204 S10000
G1 X97.479 Y107.198 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
; LAYER_HEIGHT: 0.12
G1 F16800
M204 S6000
G1 X97.314 Y107.046 E.00432
G1 X89.58 Y107.046 E.14908
G1 X89.428 Y107.212 E.00434
G1 X89.682 Y107.446 E.00666
G1 X89.746 Y107.599 E.0032
G1 X89.711 Y107.703 E.00211
G1 X89.372 Y108.197 E.01157
G1 X98.568 Y108.197 E.17726
G1 X97.523 Y107.238 E.02733
M204 S10000
G1 X97.218 Y107.482 F42000
; LINE_WIDTH: 0.404102
G1 F16800
M204 S6000
G1 X97.164 Y107.433 E.00136
G1 X90.056 Y107.433 E.13148
G1 X90.132 Y107.614 E.00364
G1 X90.066 Y107.811 E.00383
G1 X97.576 Y107.811 E.13891
G1 X97.262 Y107.523 E.00788
; OBJECT_ID: 66
; WIPE_START
G1 X97.576 Y107.811 E-.16181
G1 X96.002 Y107.811 E-.59819
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X94.426 Y100.343 Z1.56 F42000
G1 X91.107 Y84.607 Z1.56
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F21000
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z1.56 F42000
G1 X103.14 Y85.44 Z1.56
G1 Z1.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z1.56 F42000
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F21000
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.988 Y83.035 Z1.56 F42000
G1 X85.477 Y83.594 Z1.56
G1 Z1.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X76.524 Y83.594 E.18571
G3 X75.406 Y82.477 I-.009 J-1.109 E.03648
G1 X75.406 Y73.524 E.18571
G3 X76.523 Y72.406 I1.109 J-.009 E.03648
G1 X85.482 Y72.406 E.18583
G3 X86.594 Y73.524 I.005 J1.107 E.03638
G1 X86.594 Y82.477 E.18571
G3 X85.537 Y83.593 I-1.109 J.009 E.03523
M204 S10000
G1 X85.484 Y84.018 F42000
G1 F21000
M204 S6000
G1 X76.516 Y84.018 E.186
G3 X74.982 Y82.484 I0 J-1.535 E.05
G1 X74.982 Y73.516 E.186
G3 X76.516 Y71.982 I1.535 J0 E.05
G1 X85.489 Y71.982 E.18611
G3 X87.018 Y73.516 I-.004 J1.533 E.0499
G1 X87.018 Y82.484 E.186
G3 X85.543 Y84.017 I-1.535 J0 E.04875
M204 S250
G1 X85.49 Y84.427 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.51 Y84.427 E.1731
G3 X74.573 Y82.49 I.009 J-1.946 E.05858
G1 X74.573 Y73.51 E.1731
G3 X76.51 Y71.573 I1.946 J.009 E.05858
G1 X85.496 Y71.573 E.17321
G3 X87.427 Y73.51 I-.012 J1.944 E.05849
G1 X87.427 Y82.49 E.1731
G3 X85.55 Y84.426 I-1.946 J-.009 E.05743
; WIPE_START
M204 S6000
G1 X83.55 Y84.426 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.205 Y82.295 Z1.56 F42000
G1 Z1.16
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.387937
G1 F16800
M204 S6000
G1 X85.741 Y82.731 E.01128
G1 X85.468 Y82.836 E.00518
G1 X76.559 Y82.836 E.15776
G1 X76.303 Y82.765 E.0047
G3 X75.797 Y82.301 I22.332 J-24.831 E.01216
G1 X75.853 Y82.754 E.00809
G1 X76.081 Y83.046 E.00656
G1 X76.35 Y83.17 E.00524
G1 X76.559 Y83.2 E.00373
G1 X85.45 Y83.2 E.15744
G1 X85.662 Y83.165 E.00381
G1 X85.952 Y83.019 E.00575
G1 X86.12 Y82.816 E.00466
G2 X86.204 Y82.355 I-.728 J-.372 E.00843
M204 S10000
G1 X86.08 Y81.886 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F24749.689
M204 S6000
G1 X85.484 Y82.438 E.01685
G3 X83.731 Y82.242 I-.289 J-5.343 E.03675
G1 X83.276 Y82.308 E.00954
G1 X83.1 Y82.443 E.00461
G1 X77.311 Y82.442 E.12008
G1 X76.448 Y82.242 E.01836
G1 X76.324 Y82.26 E.0026
G1 X75.769 Y81.754 E.01557
G1 X75.769 Y80.321 E.02972
G1 X76.448 Y79.422 E.02337
G3 X78.724 Y78.666 I1.865 J1.813 E.0517
G1 X79.179 Y79.014 E.01189
G1 X80.09 Y80.22 E.03133
G2 X82.366 Y80.975 I1.865 J-1.813 E.0517
G1 X82.821 Y80.627 E.01188
G1 X83.731 Y79.422 E.03133
G3 X86.007 Y78.666 I1.865 J1.813 E.0517
G1 X86.23 Y78.836 E.00581
G1 X86.229 Y76.677 E.04479
G1 X85.552 Y75.78 E.02331
G2 X83.276 Y75.025 I-1.865 J1.813 E.0517
G1 X82.821 Y75.373 E.01189
G1 X81.91 Y76.578 E.03133
G3 X79.634 Y77.334 I-1.865 J-1.813 E.0517
G1 X79.179 Y76.986 E.01188
G1 X78.269 Y75.78 E.03133
G2 X75.993 Y75.025 I-1.865 J1.813 E.0517
G1 X75.769 Y75.196 E.00585
G1 X75.769 Y74.242 E.01978
G1 X76.516 Y73.562 E.02096
G1 X81.041 Y73.557 E.09386
G1 X81.91 Y73.758 E.01851
G2 X82.543 Y73.557 I.135 J-.668 E.01438
G1 X84.24 Y73.557 E.0352
M204 S10000
G1 X86.208 Y73.487 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.386419
G1 F16800
M204 S6000
G1 X86.113 Y73.167 E.0059
G1 X85.911 Y72.949 E.00524
G2 X85.446 Y72.8 I-.468 J.659 E.00874
G1 X76.532 Y72.802 E.15719
G1 X76.309 Y72.84 E.004
G1 X76.055 Y72.975 E.00508
G1 X75.88 Y73.184 E.0048
G2 X75.795 Y73.705 I.828 J.403 E.00945
G1 X76.259 Y73.269 E.01124
G1 X76.532 Y73.164 E.00516
G1 X85.446 Y73.163 E.15719
G1 X85.715 Y73.246 E.00495
G1 X86.209 Y73.717 E.01203
G1 X86.208 Y73.547 E.00299
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F16800
G1 X86.209 Y73.717 E-.06446
G1 X85.715 Y73.246 E-.25917
G1 X85.446 Y73.163 E-.10677
G1 X84.579 Y73.163 E-.3296
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 10/73
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M106 S201.45
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.56 I-1.214 J.083 P1  F42000
G1 X86.796 Y105.774 Z1.56
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15186
M204 S6000
G1 X86.719 Y105.693 E.00231
G3 X85.757 Y103.417 I2.303 J-2.315 E.05256
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.266 J.04 E.10477
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.04 J3.266 E.10477
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.266 J-.04 E.10477
G1 X88.983 Y106.643 E.19777
G3 X87.031 Y105.966 I.04 J-3.266 E.0436
G1 X86.842 Y105.812 E.00505
M204 S10000
G1 X87.072 Y105.448 F42000
G1 F15186
M204 S6000
G1 X87.016 Y105.391 E.00166
M73 P24 R9
G3 X86.181 Y103.41 I2.004 J-2.011 E.04573
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.839 J.03 E.09126
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.03 J2.839 E.09126
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.839 J-.03 E.09126
G1 X88.99 Y106.219 E.19748
G3 X87.438 Y105.738 I.03 J-2.839 E.03418
G1 X87.119 Y105.486 E.00843
M204 S250
G1 X87.331 Y105.133 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.302 Y105.1 E.00084
G3 X86.59 Y103.404 I1.716 J-1.718 E.03638
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.428 J.021 E.07269
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.021 J2.428 E.07269
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.428 J-.021 E.07269
G1 X88.996 Y105.81 E.18326
G3 X87.665 Y105.398 I.021 J-2.428 E.02725
G1 X87.378 Y105.17 E.00706
; WIPE_START
M204 S6000
G1 X87.302 Y105.1 E-.03918
G1 X86.996 Y104.739 E-.17995
G1 X86.773 Y104.322 E-.17952
G1 X86.636 Y103.87 E-.17952
G1 X86.59 Y103.404 E-.17822
G1 X86.59 Y103.394 E-.0036
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.68 F42000
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15186
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03182
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.963 J-.011 E.03182
G1 X103.779 Y88.695 E.41509
G3 X104.707 Y89.667 I-.029 J.957 E.03089
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.963 J.011 E.03182
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F15186
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.389 J-.002 E.04533
G1 X103.803 Y88.271 E.41574
G3 X105.131 Y89.66 I-.054 J1.381 E.04407
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.753 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X81.96 Y107.647 I.006 J-1.8 E.05425
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.006 E.05425
G1 X103.826 Y87.863 E.38692
G3 X105.54 Y89.653 I-.077 J1.789 E.05276
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.813 Y109.44 E.38423
; WIPE_START
M204 S6000
G1 X83.401 Y109.405 E-.15733
G1 X83.065 Y109.304 E-.13338
G1 X82.756 Y109.138 E-.13331
G1 X82.484 Y108.916 E-.13336
G1 X82.262 Y108.644 E-.13333
G1 X82.176 Y108.483 E-.0693
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.68 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 10 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer10 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X104.295 Y89.693
G1 Z1.28
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X104.253 Y89.447 E.00482
G2 X103.682 Y89.104 I-.55 J.269 E.01357
G1 X83.795 Y89.103 E.38334
G1 X83.548 Y89.148 E.00485
G2 X83.25 Y89.442 I.2 J.5 E.00828
G1 X83.203 Y89.756 E.00611
G1 X83.203 Y107.605 E.34406
G1 X83.248 Y107.852 E.00484
G2 X83.542 Y108.15 I.5 J-.2 E.00828
G1 X83.856 Y108.197 E.00612
G1 X103.705 Y108.197 E.38261
G1 X103.952 Y108.152 E.00484
G2 X104.25 Y107.858 I-.2 J-.5 E.00828
G1 X104.297 Y107.544 E.00612
G1 X104.295 Y89.753 E.34293
M204 S10000
G1 X103.9 Y89.693 F42000
; LINE_WIDTH: 0.415652
G1 F15186
M204 S6000
G1 X103.849 Y89.551 E.00288
G1 X103.682 Y89.498 E.00333
G3 X98.525 Y89.488 I-1.811 J-388.222 E.09832
G1 X88.975 Y89.488 E.18203
G3 X83.83 Y89.497 I-2.934 J-201.009 E.09808
G1 X83.65 Y89.552 E.0036
G1 X83.597 Y89.756 E.004
G1 X83.597 Y107.57 E.33959
G1 X83.653 Y107.75 E.0036
G1 X83.856 Y107.803 E.004
G1 X87.38 Y107.803 E.06718
; LINE_WIDTH: 0.439518
G3 X88.652 Y107.808 I.602 J8.067 E.02575
; LINE_WIDTH: 0.415406
G1 X98.726 Y107.811 E.19193
G3 X100.103 Y107.803 I.788 J17.153 E.02625
G1 X103.67 Y107.803 E.06794
G1 X103.85 Y107.747 E.00359
G1 X103.903 Y107.544 E.004
G1 X103.9 Y89.753 E.33895
M204 S10000
G1 X102.146 Y103.527 F42000
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X102.146 Y103.626 E.00191
G3 X101.673 Y105.21 I-3.969 J-.324 E.0321
G1 X101.365 Y105.652 E.01039
G1 X100.741 Y106.285 E.01713
G3 X99.232 Y106.979 I-2.368 J-3.16 E.03225
G1 X98.726 Y107.046 E.00984
G1 X88.778 Y107.046 E.19176
G1 X88.073 Y106.933 E.01375
G3 X86.654 Y106.198 I1.075 J-3.813 E.03102
G1 X86.115 Y105.641 E.01494
G1 X85.829 Y105.214 E.00991
G1 X85.568 Y104.646 E.01204
G3 X85.354 Y103.626 I3.34 J-1.233 E.02017
G1 X85.347 Y93.876 E.18795
G1 X85.381 Y93.408 E.00904
G1 X85.534 Y92.748 E.01306
G1 X85.827 Y92.09 E.01387
G1 X86.114 Y91.661 E.00995
G1 X86.577 Y91.167 E.01306
G1 X87.157 Y90.746 E.0138
G1 X87.62 Y90.518 E.00995
G1 X88.269 Y90.321 E.01307
G3 X88.975 Y90.247 I1.012 J6.233 E.01371
G1 X98.525 Y90.247 E.18406
G1 X98.992 Y90.281 E.00904
G1 X99.656 Y90.435 E.01313
G1 X100.31 Y90.727 E.01381
G1 X100.846 Y91.102 E.01262
G1 X101.385 Y91.659 E.01494
G1 X101.671 Y92.086 E.0099
G1 X101.932 Y92.654 E.01204
G3 X102.146 Y93.674 I-3.363 J1.238 E.02017
G1 X102.146 Y103.467 E.18876
; WIPE_START
G1 F16800
G1 X102.146 Y101.467 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.608 Y102.661 Z1.68 F42000
G1 X85.027 Y104.178 Z1.68
G1 Z1.28
G1 E.8 F1800
; LINE_WIDTH: 0.414185
G1 F15186
M204 S6000
G1 X84.959 Y103.626 E.01055
G1 X84.953 Y93.876 E.18518
G1 X84.997 Y93.319 E.01061
G1 X85.15 Y92.658 E.01287
G1 X85.468 Y91.928 E.01513
G1 X85.766 Y91.467 E.01042
G1 X86.29 Y90.897 E.0147
G1 X86.927 Y90.426 E.01506
G1 X87.415 Y90.176 E.01041
G1 X88.152 Y89.937 E.01471
G3 X88.975 Y89.863 I1.022 J6.719 E.01571
G1 X98.525 Y89.863 E.18135
G1 X99.082 Y89.894 E.0106
G1 X99.745 Y90.051 E.01293
G1 X100.472 Y90.368 E.01508
G1 X101.074 Y90.78 E.01384
G1 X101.669 Y91.387 E.01615
G1 X101.983 Y91.84 E.01047
G1 X102.29 Y92.488 E.01362
G3 X102.541 Y93.674 I-4.953 J1.665 E.02306
G1 X102.541 Y103.626 E.189
G3 X102.344 Y104.664 I-4.042 J-.226 E.02012
G1 X102.032 Y105.373 E.01471
G3 X101.546 Y106.059 I-5.534 J-3.398 E.01599
G1 X101.013 Y106.569 E.01401
G3 X100.097 Y107.119 I-2.471 J-3.084 E.02036
G1 X99.349 Y107.363 E.01493
G3 X98.726 Y107.433 I-.763 J-4 E.01192
G1 X88.778 Y107.433 E.18893
; LINE_WIDTH: 0.419285
G1 X88.392 Y107.389 E.00747
; LINE_WIDTH: 0.424869
G1 X88.006 Y107.345 E.00758
G3 X86.427 Y106.52 I1.489 J-4.778 E.03495
G1 X85.831 Y105.913 E.0166
G1 X85.517 Y105.46 E.01077
G1 X85.21 Y104.812 E.01399
G1 X85.041 Y104.236 E.0117
; WIPE_START
G1 F16800
G1 X85.21 Y104.812 E-.22788
G1 X85.517 Y105.46 E-.27251
G1 X85.831 Y105.913 E-.20963
G1 X85.923 Y106.007 E-.04998
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.48 Y98.395 Z1.68 F42000
G1 X87.102 Y89.891 Z1.68
G1 Z1.28
G1 E.8 F1800
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X83.991 Y89.891 E.05995
G1 X83.991 Y92.481 E.04991
; LINE_WIDTH: 0.439606
G1 X84.011 Y92.706 E.00459
; LINE_WIDTH: 0.478832
G1 X84.03 Y92.932 E.00502
; LINE_WIDTH: 0.510329
G1 X84.05 Y93.158 E.00537
G2 X84.035 Y93.876 I23.766 J.872 E.01702
G1 X84.036 Y103.627 E.23101
G1 X84.054 Y104.246 E.01468
; LINE_WIDTH: 0.524201
G1 X84.033 Y104.478 E.00566
; LINE_WIDTH: 0.482517
G1 X84.012 Y104.709 E.00519
; LINE_WIDTH: 0.420518
G1 X83.991 Y104.94 E.00448
G1 X83.991 Y107.409 E.04764
G1 X87.102 Y107.409 E.06004
G3 X86.199 Y106.842 I1.721 J-3.745 E.02063
G1 X85.546 Y106.186 E.01788
G1 X85.189 Y105.679 E.01197
G1 X84.852 Y104.977 E.01503
; LINE_WIDTH: 0.44167
G1 X84.735 Y104.665 E.00677
; LINE_WIDTH: 0.485025
G1 X84.619 Y104.353 E.00748
; LINE_WIDTH: 0.510343
G1 X84.571 Y104.212 E.00352
G1 X84.52 Y103.627 E.01392
G1 X84.515 Y93.876 E.23102
G1 X84.555 Y93.216 E.01567
; LINE_WIDTH: 0.518059
G1 X84.626 Y93.001 E.00546
; LINE_WIDTH: 0.478832
G1 X84.696 Y92.785 E.00502
; LINE_WIDTH: 0.421157
G1 X84.766 Y92.569 E.00438
G1 X85.108 Y91.766 E.01689
G1 X85.438 Y91.248 E.01186
G1 X86.002 Y90.627 E.01621
G1 X86.697 Y90.106 E.01681
G1 X87.049 Y89.92 E.00768
M204 S10000
G1 X85.797 Y90.286 F42000
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X84.385 Y90.285 E.0272
G1 X84.385 Y92.47 E.0421
G1 X84.749 Y91.603 E.01811
G1 X85.11 Y91.029 E.01307
G1 X85.752 Y90.325 E.01836
M204 S10000
G1 X84.841 Y90.663 F42000
; LINE_WIDTH: 0.484932
G1 F15186
M204 S6000
G2 X84.838 Y90.762 I-.029 J.049 E.00529
M204 S10000
G1 X84.385 Y104.82 F42000
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X84.385 Y107.015 E.0423
G1 X85.798 Y107.015 E.02723
G1 X85.261 Y106.459 E.0149
G1 X84.861 Y105.898 E.01328
G1 X84.494 Y105.142 E.0162
G1 X84.405 Y104.877 E.00539
M204 S10000
G1 X84.841 Y106.538 F42000
; LINE_WIDTH: 0.484952
G1 F15186
M204 S6000
G2 X84.838 Y106.638 I-.029 J.049 E.00529
; WIPE_START
G1 F16800
G1 X84.783 Y106.638 E-.1835
G1 X84.755 Y106.588 E-.19217
G1 X84.783 Y106.538 E-.19217
G1 X84.841 Y106.538 E-.19217
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X90.537 Y101.458 Z1.68 F42000
G1 X103.506 Y89.893 Z1.68
G1 Z1.28
G1 E.8 F1800
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X100.378 Y89.892 E.0603
G1 X100.797 Y90.102 E.00903
G1 X101.301 Y90.458 E.0119
G1 X101.954 Y91.114 E.01784
G1 X102.311 Y91.621 E.01195
G1 X102.648 Y92.323 E.01501
; LINE_WIDTH: 0.436452
G1 X102.76 Y92.637 E.00668
; LINE_WIDTH: 0.469372
G1 X102.871 Y92.95 E.00721
; LINE_WIDTH: 0.50038
G1 X102.9 Y93.019 E.00173
; LINE_WIDTH: 0.511198
G1 X102.929 Y93.088 E.00177
G1 X102.979 Y93.674 E.01397
G1 X102.98 Y103.626 E.23621
G1 X102.929 Y104.211 E.01394
; LINE_WIDTH: 0.523942
G1 X102.861 Y104.396 E.0048
; LINE_WIDTH: 0.482362
G1 X102.793 Y104.581 E.0044
; LINE_WIDTH: 0.420425
G3 X102.391 Y105.535 I-8.429 J-2.993 E.02
G3 X101.819 Y106.344 I-5.02 J-2.944 E.01914
G1 X101.286 Y106.854 E.01423
G1 X100.776 Y107.213 E.01203
G1 X100.399 Y107.409 E.0082
G1 X103.509 Y107.409 E.06
G1 X103.508 Y104.869 E.04901
; LINE_WIDTH: 0.441492
G1 X103.487 Y104.68 E.00388
; LINE_WIDTH: 0.484492
G1 X103.465 Y104.49 E.00428
; LINE_WIDTH: 0.511515
G1 X103.444 Y104.301 E.00453
G2 X103.463 Y103.626 I-19.93 J-.917 E.01604
G1 X103.462 Y93.674 E.23636
G1 X103.445 Y93.054 E.01474
; LINE_WIDTH: 0.523351
G1 X103.465 Y92.822 E.00565
; LINE_WIDTH: 0.482007
G1 X103.486 Y92.591 E.00518
; LINE_WIDTH: 0.42181
G1 X103.507 Y92.36 E.0045
G1 X103.506 Y89.953 E.04662
M204 S10000
G1 X103.112 Y90.287 F42000
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X101.704 Y90.287 E.02715
G1 X102.239 Y90.841 E.01486
G1 X102.639 Y91.402 E.01327
G1 X103.006 Y92.158 E.0162
G1 X103.112 Y92.472 E.00639
G1 X103.112 Y90.347 E.04097
M204 S10000
G1 X102.715 Y90.663 F42000
; LINE_WIDTH: 0.482612
G1 F15186
M204 S6000
G2 X102.712 Y90.762 I-.029 J.049 E.00522
M204 S10000
G1 X103.11 Y104.869 F42000
; LINE_WIDTH: 0.419992
G1 F15186
M204 S6000
G1 X102.75 Y105.698 E.01743
G1 X102.331 Y106.334 E.01468
G3 X101.689 Y107.015 I-3.023 J-2.21 E.01808
G1 X103.114 Y107.015 E.02749
G2 X103.111 Y104.929 I-57.894 J-.949 E.0402
M204 S10000
G1 X102.712 Y106.532 F42000
; LINE_WIDTH: 0.494372
G1 F15186
M204 S6000
G2 X102.711 Y106.634 I-.029 J.05 E.00556
; OBJECT_ID: 66
; WIPE_START
G1 F16800
G1 X102.654 Y106.634 E-.18649
G1 X102.624 Y106.583 E-.19117
G1 X102.654 Y106.532 E-.19119
G1 X102.712 Y106.532 E-.19116
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X99.142 Y99.787 Z1.68 F42000
G1 X91.107 Y84.607 Z1.68
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15186
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F15186
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
M73 P25 R9
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z1.68 F42000
G1 X103.14 Y85.44 Z1.68
G1 Z1.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z1.68 F42000
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15186
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F15186
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.987 Y83.029 Z1.68 F42000
G1 X85.47 Y83.58 Z1.68
G1 Z1.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15186
M204 S6000
G1 X76.53 Y83.58 E.18543
G3 X75.42 Y82.47 I-.01 J-1.101 E.03627
G1 X75.42 Y73.53 E.18544
G3 X76.53 Y72.42 I1.102 J-.008 E.03625
G1 X85.477 Y72.42 E.18559
G3 X86.58 Y73.53 I.003 J1.1 E.03611
G1 X86.58 Y82.47 E.18543
G3 X85.53 Y83.579 I-1.102 J.008 E.03501
M204 S10000
G1 X85.477 Y84.005 F42000
G1 F15186
M204 S6000
G1 X76.523 Y84.005 E.18572
G3 X74.995 Y82.477 I-.001 J-1.526 E.04979
G1 X74.995 Y73.523 E.18572
G3 X76.523 Y71.995 I1.528 J0 E.04977
G1 X85.484 Y71.996 E.18588
G3 X87.005 Y73.523 I-.006 J1.526 E.04963
G1 X87.005 Y82.477 E.18572
G3 X85.537 Y84.003 I-1.528 J0 E.04853
M204 S250
G1 X85.484 Y84.414 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.517 Y84.414 E.17285
G3 X74.586 Y82.484 I.007 J-1.937 E.05839
G1 X74.586 Y73.517 E.17285
G3 X76.517 Y71.586 I1.939 J.009 E.05837
G1 X85.491 Y71.586 E.17299
G3 X87.414 Y73.517 I-.014 J1.937 E.05824
G1 X87.414 Y82.484 E.17285
G3 X85.543 Y84.413 I-1.939 J-.009 E.05722
; WIPE_START
M204 S6000
G1 X83.543 Y84.413 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.196 Y82.298 Z1.68 F42000
G1 Z1.28
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.380945
G1 F15186
M204 S6000
G1 X85.738 Y82.728 E.0109
G1 X85.468 Y82.832 E.00504
G1 X76.565 Y82.832 E.1546
G1 X76.304 Y82.762 E.0047
G3 X75.806 Y82.304 I22.756 J-25.278 E.01174
G1 X75.864 Y82.75 E.00781
G1 X76.086 Y83.035 E.00627
G1 X76.353 Y83.16 E.00511
G1 X76.565 Y83.19 E.00373
G1 X85.443 Y83.19 E.15418
G1 X85.658 Y83.154 E.00378
G1 X85.968 Y82.985 E.00613
G1 X86.111 Y82.809 E.00393
G2 X86.195 Y82.358 I-.71 J-.366 E.00808
M204 S10000
G1 X85.979 Y81.981 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15186
M204 S6000
G3 X85.484 Y82.438 I-1.212 J-.814 E.0141
G3 X84.186 Y82.377 I-.329 J-6.78 E.02698
G3 X77.172 Y82.442 I-4.507 J-107.935 E.14553
G2 X76.433 Y82.362 I-.681 J2.859 E.01545
G1 X75.783 Y81.767 E.01829
G1 X75.783 Y80.148 E.03359
G3 X77.358 Y78.845 I2.756 J1.73 E.04314
G3 X78.724 Y78.839 I.691 J1.942 E.02887
G1 X79.179 Y79.209 E.01216
G1 X80.09 Y80.269 E.02898
G2 X82.366 Y80.802 I1.608 J-1.738 E.05071
G1 X82.821 Y80.433 E.01216
G1 X83.731 Y79.373 E.02898
G3 X86.007 Y78.839 I1.608 J1.738 E.05071
G1 X86.216 Y79.009 E.00559
G1 X86.216 Y76.504 E.05197
G2 X84.642 Y75.204 I-2.753 J1.73 E.04307
G2 X83.276 Y75.198 I-.691 J1.942 E.02887
G1 X82.821 Y75.567 E.01216
G1 X81.91 Y76.628 E.02898
G3 X79.634 Y77.161 I-1.608 J-1.738 E.05071
G1 X79.179 Y76.791 E.01216
G1 X78.269 Y75.731 E.02898
G2 X75.993 Y75.198 I-1.608 J1.738 E.05071
G1 X75.783 Y75.369 E.00562
G1 X75.783 Y74.23 E.02363
G1 X76.516 Y73.562 E.02058
G1 X81.18 Y73.557 E.09673
G2 X82.226 Y73.557 I.523 J-1.764 E.02201
G1 X83.923 Y73.557 E.0352
M204 S10000
G1 X86.199 Y73.494 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.379308
G1 F15186
M204 S6000
G1 X86.104 Y73.174 E.00576
G1 X85.852 Y72.927 E.0061
G2 X85.442 Y72.81 I-.478 J.896 E.00742
G1 X76.532 Y72.812 E.15402
G1 X76.317 Y72.849 E.00377
G1 X76.064 Y72.983 E.00496
G1 X75.889 Y73.191 E.00468
G2 X75.804 Y73.702 I.81 J.398 E.00908
G1 X76.262 Y73.272 E.01086
G1 X76.532 Y73.168 E.00501
G1 X85.443 Y73.167 E.15402
G1 X85.712 Y73.249 E.00487
G1 X86.199 Y73.713 E.01164
G1 X86.199 Y73.554 E.00276
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F16800
G1 X86.199 Y73.713 E-.06065
G1 X85.712 Y73.249 E-.25579
G1 X85.443 Y73.167 E-.10695
G1 X84.557 Y73.167 E-.33662
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 11/73
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.68 I-1.214 J.083 P1  F42000
G1 X86.799 Y105.776 Z1.68
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13816
M204 S6000
G1 X86.717 Y105.692 E.00241
G3 X85.757 Y103.417 I2.304 J-2.313 E.05254
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.264 J.038 E.10478
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.038 J3.264 E.10478
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X87.031 Y105.967 I.038 J-3.264 E.04361
G1 X86.845 Y105.814 E.00499
M204 S10000
G1 X87.074 Y105.45 F42000
G1 F13816
M204 S6000
G1 X87.015 Y105.391 E.00173
G3 X86.181 Y103.41 I2.004 J-2.01 E.04572
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.838 J.029 E.09127
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.029 J2.838 E.09127
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.438 Y105.738 I.029 J-2.838 E.03418
G1 X87.121 Y105.487 E.00838
M204 S250
G1 X87.333 Y105.135 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.302 Y105.1 E.00089
G3 X86.59 Y103.404 I1.715 J-1.717 E.03638
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.427 J.02 E.0727
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.02 J2.427 E.0727
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.665 Y105.398 I.02 J-2.427 E.02725
G1 X87.38 Y105.172 E.00702
; WIPE_START
M204 S6000
G1 X87.302 Y105.1 E-.04027
G1 X86.996 Y104.739 E-.17982
G1 X86.773 Y104.322 E-.17952
G1 X86.636 Y103.87 E-.17953
G1 X86.59 Y103.404 E-.17822
G1 X86.59 Y103.397 E-.00264
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13816
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03182
G1 X82.793 Y89.667 E.37265
G3 X83.767 Y88.693 I.963 J-.011 E.03182
G1 X103.786 Y88.695 E.41524
G3 X104.707 Y89.667 I-.037 J.957 E.03074
G1 X104.707 Y107.633 E.37265
G3 X103.733 Y108.607 I-.963 J.011 E.03182
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F13816
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.389 J-.002 E.04533
G1 X103.811 Y88.272 E.41591
G3 X105.131 Y89.66 I-.062 J1.38 E.0439
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.753 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X81.96 Y107.647 I.006 J-1.8 E.05425
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.006 E.05425
G1 X103.835 Y87.863 E.38709
G3 X105.54 Y89.653 I-.086 J1.789 E.0526
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.813 Y109.44 E.38423
; WIPE_START
M204 S6000
G1 X83.401 Y109.405 E-.15732
G1 X83.064 Y109.303 E-.13387
G1 X82.756 Y109.138 E-.13283
G1 X82.484 Y108.916 E-.13337
G1 X82.261 Y108.643 E-.13383
G1 X82.176 Y108.484 E-.06879
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 11 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer11 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.716 Y106.538
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.485132
G1 F13816
M204 S6000
G2 X102.714 Y106.637 I-.029 J.049 E.00529
M204 S10000
G1 X103.115 Y104.829 F42000
; LINE_WIDTH: 0.419992
G1 F13816
M204 S6000
G3 X102.347 Y106.331 I-5.256 J-1.74 E.03264
M73 P26 R9
G1 X101.703 Y107.015 E.0181
G1 X103.115 Y107.015 E.02721
G1 X103.115 Y104.889 E.04097
M204 S10000
G1 X102.98 Y103.622 F42000
; LINE_WIDTH: 0.525867
G1 F13816
M204 S6000
G1 X102.934 Y104.045 E.01038
; LINE_WIDTH: 0.557877
G1 X102.887 Y104.467 E.01105
; LINE_WIDTH: 0.554646
G1 X102.822 Y104.61 E.00407
; LINE_WIDTH: 0.516173
G1 X102.757 Y104.753 E.00377
; LINE_WIDTH: 0.477701
G1 X102.692 Y104.896 E.00348
; LINE_WIDTH: 0.420335
G3 X102.378 Y105.564 I-20.128 J-9.069 E.01424
G1 X102.064 Y106.049 E.01114
G1 X101.502 Y106.669 E.01615
G1 X100.803 Y107.194 E.01686
G1 X100.398 Y107.409 E.00884
G1 X103.509 Y107.409 E.06001
G1 X103.509 Y105.185 E.04289
; LINE_WIDTH: 0.439382
G1 X103.489 Y105.02 E.00336
; LINE_WIDTH: 0.478162
G1 X103.47 Y104.856 E.00367
; LINE_WIDTH: 0.516942
G1 X103.451 Y104.691 E.00399
; LINE_WIDTH: 0.548455
G1 X103.431 Y104.526 E.00424
G1 X103.46 Y103.83 E.0178
; LINE_WIDTH: 0.510957
G1 X103.464 Y93.674 E.24093
G1 X103.446 Y93.054 E.01472
; LINE_WIDTH: 0.524217
G1 X103.467 Y92.827 E.00555
; LINE_WIDTH: 0.482527
G1 X103.488 Y92.6 E.00509
; LINE_WIDTH: 0.420505
G1 X103.509 Y92.373 E.0044
G1 X103.509 Y89.893 E.04788
G1 X100.378 Y89.893 E.06042
G1 X100.798 Y90.103 E.00905
G1 X101.311 Y90.466 E.01214
G1 X101.956 Y91.115 E.01766
G1 X102.311 Y91.621 E.01193
G1 X102.653 Y92.335 E.01527
; LINE_WIDTH: 0.43678
G1 X102.762 Y92.643 E.00658
; LINE_WIDTH: 0.470355
G1 X102.872 Y92.952 E.00712
; LINE_WIDTH: 0.501622
G1 X102.901 Y93.02 E.00172
; LINE_WIDTH: 0.510989
G1 X102.929 Y93.088 E.00175
G1 X102.98 Y93.674 E.01396
G1 X102.98 Y103.562 E.2346
M204 S10000
G1 X103.115 Y92.477 F42000
; LINE_WIDTH: 0.419992
G1 F13816
M204 S6000
G1 X103.115 Y90.287 E.04222
G1 X101.704 Y90.287 E.02719
G1 X102.241 Y90.843 E.0149
G1 X102.639 Y91.402 E.01323
G1 X103.011 Y92.17 E.01645
G1 X103.095 Y92.421 E.00509
M204 S10000
G1 X102.717 Y90.664 F42000
; LINE_WIDTH: 0.484152
G1 F13816
M204 S6000
G2 X102.714 Y90.763 I-.029 J.049 E.00527
M204 S10000
G1 X98.525 Y89.863 F42000
; LINE_WIDTH: 0.41542
G1 F13816
M204 S6000
G1 X99.086 Y89.895 E.01072
G1 X99.749 Y90.052 E.01298
G1 X100.473 Y90.368 E.01504
G1 X101.083 Y90.788 E.01411
G1 X101.67 Y91.388 E.01599
G1 X101.983 Y91.84 E.01049
G1 X102.295 Y92.5 E.01389
G3 X102.541 Y93.674 I-4.97 J1.654 E.02291
G1 X102.541 Y103.622 E.18953
G1 X102.422 Y104.39 E.0148
G3 X101.736 Y105.83 I-4.327 J-1.18 E.03054
G1 X101.214 Y106.4 E.01473
G1 X100.573 Y106.874 E.01518
G3 X99.593 Y107.312 I-2.522 J-4.33 E.02049
G1 X98.733 Y107.432 E.01654
G1 X88.778 Y107.433 E.18967
; LINE_WIDTH: 0.419282
G1 X88.392 Y107.389 E.00747
; LINE_WIDTH: 0.421428
G1 X88.006 Y107.345 E.00751
G3 X86.417 Y106.512 I1.486 J-4.77 E.03489
G1 X85.83 Y105.912 E.01625
G1 X85.517 Y105.46 E.01065
G1 X85.205 Y104.8 E.0141
G3 X84.959 Y103.626 I3.68 J-1.384 E.0233
G1 X84.953 Y93.876 E.18864
G1 X84.997 Y93.319 E.01081
G1 X85.151 Y92.655 E.01318
G1 X85.352 Y92.148 E.01055
G1 X85.755 Y91.484 E.01502
G1 X86.103 Y91.074 E.0104
G1 X86.701 Y90.571 E.01511
G1 X87.398 Y90.185 E.01541
G1 X88.152 Y89.937 E.01536
; LINE_WIDTH: 0.401848
G3 X88.975 Y89.863 I1.024 J6.737 E.01521
G1 X98.465 Y89.863 E.17449
M204 S10000
G1 X98.525 Y89.488 F42000
; LINE_WIDTH: 0.415075
G1 F13816
M204 S6000
G1 X88.975 Y89.488 E.18177
G3 X83.832 Y89.497 I-2.932 J-201.064 E.09791
G1 X83.65 Y89.552 E.00361
G1 X83.597 Y89.758 E.00405
G1 X83.597 Y107.568 E.33902
G1 X83.652 Y107.75 E.00361
G1 X83.858 Y107.803 E.00405
G1 X87.38 Y107.803 E.06704
; LINE_WIDTH: 0.439513
G3 X88.652 Y107.808 I.602 J8.066 E.02576
; LINE_WIDTH: 0.404199
G1 X98.733 Y107.811 E.18654
; LINE_WIDTH: 0.419562
G1 X99.134 Y107.796 E.00773
; LINE_WIDTH: 0.420975
G3 X100.121 Y107.803 I.445 J6.379 E.01907
G1 X103.669 Y107.803 E.06857
G1 X103.851 Y107.747 E.00367
G1 X103.903 Y107.542 E.00409
G1 X103.903 Y89.754 E.34373
G1 X103.847 Y89.549 E.0041
G1 X103.648 Y89.499 E.00397
G2 X99.132 Y89.501 I-1.969 J623.487 E.08726
; LINE_WIDTH: 0.413057
G1 X98.585 Y89.489 E.01037
M204 S10000
G1 X84.841 Y90.663 F42000
; LINE_WIDTH: 0.484932
G1 F13816
M204 S6000
G2 X84.838 Y90.762 I-.029 J.049 E.00529
M204 S10000
G1 X84.385 Y92.468 F42000
; LINE_WIDTH: 0.419992
G1 F13816
M204 S6000
G1 X84.624 Y91.846 E.01284
G1 X85.085 Y91.068 E.01743
G1 X85.509 Y90.555 E.01284
G1 X85.808 Y90.286 E.00775
G1 X84.385 Y90.285 E.02742
G1 X84.385 Y92.408 E.04092
M204 S10000
G1 X84.515 Y93.876 F42000
; LINE_WIDTH: 0.522192
G1 F13816
M204 S6000
G1 X84.555 Y93.216 E.01605
; LINE_WIDTH: 0.518092
G1 X84.626 Y92.999 E.00549
; LINE_WIDTH: 0.478852
G1 X84.696 Y92.783 E.00505
; LINE_WIDTH: 0.420458
G3 X84.988 Y91.997 I7.087 J2.185 E.01618
G1 X85.42 Y91.276 E.01622
G1 X85.806 Y90.815 E.01162
G1 X86.45 Y90.267 E.01631
G1 X87.111 Y89.891 E.01467
G1 X83.991 Y89.891 E.06021
G1 X83.991 Y92.477 E.0499
; LINE_WIDTH: 0.439612
G1 X84.011 Y92.704 E.00461
; LINE_WIDTH: 0.478852
G1 X84.03 Y92.931 E.00505
; LINE_WIDTH: 0.510332
G1 X84.05 Y93.158 E.0054
G2 X84.035 Y93.876 I23.738 J.872 E.01702
G1 X84.036 Y103.627 E.23101
G1 X84.054 Y104.246 E.01468
; LINE_WIDTH: 0.524209
G1 X84.033 Y104.473 E.00555
; LINE_WIDTH: 0.482522
G1 X84.012 Y104.7 E.00509
; LINE_WIDTH: 0.420507
G1 X83.991 Y104.926 E.0044
G1 X83.991 Y107.409 E.04791
G1 X87.102 Y107.409 E.06004
G1 X86.705 Y107.199 E.00866
G1 X86.189 Y106.834 E.0122
G1 X85.544 Y106.184 E.01767
G1 X85.189 Y105.679 E.01193
G1 X84.847 Y104.965 E.01527
; LINE_WIDTH: 0.44189
G1 X84.733 Y104.658 E.00667
; LINE_WIDTH: 0.485685
G1 X84.618 Y104.351 E.00737
; LINE_WIDTH: 0.509608
G1 X84.571 Y104.212 E.00347
G1 X84.52 Y103.627 E.0139
G1 X84.515 Y93.936 E.22925
M204 S10000
G1 X85.347 Y93.876 F42000
; LINE_WIDTH: 0.419992
G1 F13816
M204 S6000
G1 X85.381 Y93.408 E.00904
G1 X85.535 Y92.744 E.01313
G1 X85.731 Y92.27 E.00989
G1 X86.09 Y91.692 E.01312
G1 X86.423 Y91.311 E.00975
G1 X86.952 Y90.876 E.0132
G1 X87.584 Y90.533 E.01387
G1 X88.268 Y90.322 E.01381
G3 X88.975 Y90.247 I1.011 J6.228 E.01371
G1 X98.525 Y90.247 E.18406
G1 X98.996 Y90.281 E.00911
G1 X99.659 Y90.436 E.01313
G1 X100.31 Y90.727 E.01373
G1 X100.855 Y91.109 E.01284
G1 X101.385 Y91.66 E.01472
G1 X101.671 Y92.087 E.0099
G1 X101.936 Y92.664 E.01226
G3 X102.146 Y93.674 I-3.369 J1.227 E.01995
G1 X102.146 Y103.622 E.19176
G1 X102.033 Y104.327 E.01375
G3 X101.388 Y105.636 I-3.889 J-1.103 E.02829
G1 X100.926 Y106.131 E.01306
G1 X100.343 Y106.554 E.01388
G3 X98.766 Y107.043 I-1.943 J-3.474 E.03207
G1 X88.778 Y107.046 E.19253
G1 X88.073 Y106.933 E.01375
G3 X86.645 Y106.191 I1.075 J-3.812 E.03125
G1 X86.115 Y105.64 E.01473
G1 X85.829 Y105.214 E.0099
G1 X85.564 Y104.636 E.01226
G3 X85.354 Y103.626 I3.35 J-1.223 E.01995
G1 X85.347 Y93.936 E.18679
M204 S10000
G1 X84.385 Y104.823 F42000
; LINE_WIDTH: 0.419992
G1 F13816
M204 S6000
G1 X84.385 Y107.015 E.04225
G1 X85.798 Y107.015 E.02723
G1 X85.259 Y106.456 E.01495
G1 X84.861 Y105.898 E.01322
G1 X84.489 Y105.13 E.01645
G1 X84.405 Y104.879 E.00509
M204 S10000
G1 X84.841 Y106.538 F42000
; LINE_WIDTH: 0.484952
G1 F13816
M204 S6000
G2 X84.838 Y106.638 I-.029 J.049 E.00529
M204 S10000
G1 X83.858 Y108.197 F42000
; LINE_WIDTH: 0.419992
G1 F13816
M204 S6000
G1 X103.705 Y108.197 E.38256
G1 X103.954 Y108.152 E.00487
G2 X104.248 Y107.863 I-.201 J-.499 E.00815
G1 X104.297 Y107.542 E.00626
G1 X104.297 Y89.754 E.34287
G1 X104.252 Y89.446 E.00599
G2 X103.96 Y89.151 I-.502 J.202 E.00822
G1 X103.648 Y89.104 E.00609
G1 X83.795 Y89.103 E.38267
G1 X83.542 Y89.15 E.00497
G2 X83.252 Y89.437 I.205 J.496 E.00806
G1 X83.203 Y89.758 E.00626
G1 X83.203 Y107.605 E.34401
G1 X83.25 Y107.858 E.00497
G2 X83.799 Y108.188 I.525 J-.253 E.01306
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X83.537 Y108.148 E-.10063
G1 X83.367 Y108.034 E-.07764
G1 X83.25 Y107.858 E-.08012
G1 X83.203 Y107.605 E-.09806
G1 X83.203 Y106.543 E-.40355
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X85.79 Y99.362 Z1.8 F42000
G1 X91.107 Y84.607 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13816
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F13816
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z1.8 F42000
G1 X103.14 Y85.44 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13816
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F13816
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.987 Y83.024 Z1.8 F42000
G1 X85.463 Y83.567 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13816
M204 S6000
G1 X76.537 Y83.567 E.18515
G3 X75.433 Y82.463 I-.01 J-1.094 E.03605
G1 X75.433 Y73.537 E.18515
G3 X76.537 Y72.433 I1.096 J-.008 E.03604
G1 X85.473 Y72.434 E.18535
G3 X86.567 Y73.537 I.001 J1.093 E.03584
G1 X86.567 Y82.463 E.18516
G3 X85.523 Y83.566 I-1.094 J.01 E.03481
M204 S10000
G1 X85.47 Y83.991 F42000
G1 F13816
M204 S6000
G1 X76.53 Y83.991 E.18544
G3 X75.009 Y82.47 I-.001 J-1.52 E.04957
G1 X75.009 Y73.53 E.18544
G3 X76.53 Y72.009 I1.522 J.001 E.04955
G1 X85.48 Y72.009 E.18565
G3 X86.991 Y73.53 I-.008 J1.519 E.04936
G1 X86.991 Y82.47 E.18544
G3 X85.53 Y83.99 I-1.52 J.001 E.04833
M204 S250
G1 X85.477 Y84.4 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.523 Y84.4 E.17258
G3 X74.6 Y82.477 I.007 J-1.93 E.05819
G1 X74.6 Y73.523 E.17258
G3 X76.523 Y71.6 I1.933 J.009 E.05817
G1 X85.487 Y71.6 E.17277
G3 X87.4 Y73.523 I-.016 J1.93 E.058
G1 X87.4 Y82.477 E.17258
G3 X85.537 Y84.399 I-1.93 J-.007 E.05703
; WIPE_START
M204 S6000
G1 X83.537 Y84.399 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.204 Y81.557 Z1.8 F42000
M73 P27 R9
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13816
M204 S6000
G3 X86.105 Y82.841 I-2.571 J.448 E.02699
G3 X85.823 Y83.113 I-.671 J-.414 E.00821
G2 X84.642 Y82.513 I-3.389 J5.215 E.02754
G2 X82.821 Y83.011 I-.512 J1.707 E.04126
G1 X82.436 Y83.204 E.00894
G1 X78.705 Y83.204 E.07739
G2 X77.358 Y82.513 I-4.079 J6.29 E.03144
G2 X75.856 Y82.744 I-.509 J1.691 E.0326
G3 X75.796 Y82.446 I.587 J-.273 E.00635
G1 X75.796 Y80.002 E.05069
G3 X77.358 Y78.871 I2.436 J1.721 E.04074
G3 X79.179 Y79.369 I.512 J1.707 E.04126
G1 X80.09 Y80.321 E.02732
G2 X82.366 Y80.655 I1.418 J-1.744 E.05009
G2 X83.731 Y79.32 I-5.393 J-6.886 E.03968
G3 X86.007 Y78.987 I1.418 J1.744 E.05009
G1 X86.203 Y79.151 E.0053
G1 X86.202 Y76.359 E.05793
G2 X84.642 Y75.23 I-2.432 J1.72 E.04068
G2 X82.821 Y75.728 I-.512 J1.707 E.04126
G1 X81.91 Y76.68 E.02732
G3 X79.634 Y77.013 I-1.418 J-1.744 E.05009
G3 X78.269 Y75.679 I5.393 J-6.886 E.03968
G2 X75.993 Y75.345 I-1.418 J1.744 E.05009
G1 X75.796 Y75.511 E.00533
G3 X75.803 Y73.431 I16.792 J-.981 E.04317
G3 X76.483 Y72.799 I.729 J.102 E.02083
G1 X79.86 Y72.798 E.07006
G2 X82.366 Y73.372 I1.651 J-1.45 E.05695
G2 X83.005 Y72.797 I-2.297 J-3.198 E.01786
G1 X84.702 Y72.797 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X83.005 Y72.797 E-.64486
G1 X82.779 Y73 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 12/73
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I-1.208 J.148 P1  F42000
G1 X86.801 Y105.777 Z1.8
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
G1 F13796
M204 S6000
G1 X86.711 Y105.689 E.00262
G3 X85.757 Y103.417 I2.305 J-2.305 E.05241
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.259 J.033 E.10483
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.033 J3.259 E.10483
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X87.029 Y105.968 I.033 J-3.259 E.04362
G1 X86.847 Y105.816 E.00493
M204 S10000
G1 X87.081 Y105.459 F42000
G1 F13796
M204 S6000
G1 X87.011 Y105.389 E.00204
G3 X86.181 Y103.41 I2.003 J-2.003 E.04565
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.287 Y105.632 I.024 J-2.833 E.03801
G1 X87.126 Y105.497 E.00435
M204 S250
G1 X87.335 Y105.136 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.299 Y105.101 E.00097
G3 X86.59 Y103.404 I1.713 J-1.713 E.03637
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.664 Y105.4 I.016 J-2.422 E.02726
G1 X87.382 Y105.174 E.00697
; WIPE_START
M204 S6000
G1 X87.299 Y105.101 E-.04186
G1 X86.996 Y104.739 E-.17934
G1 X86.773 Y104.322 E-.17953
G1 X86.636 Y103.87 E-.17955
G1 X86.59 Y103.404 E-.17819
G1 X86.59 Y103.4 E-.00153
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z1.92 F42000
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13796
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03182
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.963 J-.011 E.03182
G1 X103.793 Y88.695 E.41539
G3 X104.707 Y89.667 I-.044 J.957 E.0306
G1 X104.707 Y107.633 E.37265
G3 X103.733 Y108.607 I-.963 J.011 E.03182
G1 X83.827 Y108.607 E.41289
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F13796
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.389 J-.002 E.04533
G1 X103.819 Y88.272 E.41606
G3 X105.131 Y89.66 I-.07 J1.38 E.04375
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.753 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X81.96 Y107.647 I.006 J-1.8 E.05425
M73 P27 R8
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.006 E.05425
G1 X103.843 Y87.863 E.38725
G3 X105.54 Y89.653 I-.095 J1.789 E.05244
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
G1 X83.813 Y109.44 E.38423
; WIPE_START
M204 S6000
G1 X83.401 Y109.405 E-.15731
G1 X83.064 Y109.303 E-.13379
G1 X82.756 Y109.138 E-.1329
G1 X82.484 Y108.916 E-.13332
G1 X82.262 Y108.644 E-.13334
G1 X82.176 Y108.483 E-.06934
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.92 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 12 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer12 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.716 Y106.538
G1 Z1.52
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.485132
G1 F13796
M204 S6000
G2 X102.714 Y106.637 I-.029 J.049 E.00529
M204 S10000
G1 X103.111 Y104.866 F42000
; LINE_WIDTH: 0.419992
G1 F13796
M204 S6000
G1 X102.751 Y105.697 E.01746
G1 X102.392 Y106.268 E.013
G1 X101.79 Y106.938 E.01737
G1 X101.703 Y107.015 E.00222
G1 X103.115 Y107.015 E.02721
G2 X103.112 Y104.926 I-61.698 J-.96 E.04027
M204 S10000
G1 X102.98 Y103.626 F42000
; LINE_WIDTH: 0.527427
G1 F13796
M204 S6000
G1 X102.929 Y104.211 E.01441
; LINE_WIDTH: 0.524159
G1 X102.862 Y104.395 E.00477
; LINE_WIDTH: 0.482492
G1 X102.794 Y104.579 E.00437
; LINE_WIDTH: 0.420423
G3 X102.392 Y105.534 I-8.708 J-3.104 E.02002
G1 X102.064 Y106.049 E.01177
G1 X101.502 Y106.669 E.01616
G1 X100.803 Y107.194 E.01687
G1 X100.398 Y107.409 E.00884
G1 X103.509 Y107.409 E.06003
G1 X103.509 Y104.866 E.04907
; LINE_WIDTH: 0.441536
G1 X103.487 Y104.677 E.00385
; LINE_WIDTH: 0.484622
G1 X103.466 Y104.489 E.00425
; LINE_WIDTH: 0.512149
G1 X103.444 Y104.301 E.0045
G2 X103.464 Y103.626 I-19.926 J-.919 E.01606
G1 X103.464 Y93.674 E.23667
G1 X103.446 Y93.054 E.01475
; LINE_WIDTH: 0.524192
G1 X103.467 Y92.832 E.00544
; LINE_WIDTH: 0.482512
G1 X103.488 Y92.61 E.00498
; LINE_WIDTH: 0.420493
G1 X103.509 Y92.388 E.00431
G1 X103.509 Y89.893 E.04815
G1 X100.379 Y89.893 E.0604
G1 X100.799 Y90.103 E.00906
G1 X101.352 Y90.5 E.01314
G1 X101.793 Y90.921 E.01177
G1 X102.292 Y91.594 E.01617
G1 X102.657 Y92.347 E.01615
; LINE_WIDTH: 0.437005
G1 X102.765 Y92.65 E.00648
; LINE_WIDTH: 0.47103
G1 X102.873 Y92.954 E.00702
; LINE_WIDTH: 0.50229
G1 X102.901 Y93.021 E.00169
; LINE_WIDTH: 0.510986
G1 X102.929 Y93.088 E.00172
G1 X102.98 Y93.674 E.01395
G1 X102.98 Y103.566 E.23468
M204 S10000
G1 X103.115 Y92.474 F42000
; LINE_WIDTH: 0.419992
G1 F13796
M204 S6000
G1 X103.115 Y90.287 E.04215
G1 X101.71 Y90.287 E.02708
G1 X102.072 Y90.642 E.00978
G1 X102.612 Y91.364 E.01738
G1 X103.016 Y92.183 E.01759
G1 X103.095 Y92.417 E.00478
M204 S10000
G1 X102.712 Y90.669 F42000
; LINE_WIDTH: 0.496392
G1 F13796
M204 S6000
G2 X102.71 Y90.771 I-.029 J.051 E.00562
M204 S10000
G1 X98.525 Y89.863 F42000
; LINE_WIDTH: 0.415124
G1 F13796
M204 S6000
G1 X99.086 Y89.895 E.01071
G1 X99.745 Y90.051 E.0129
G1 X100.469 Y90.366 E.01502
G1 X101.123 Y90.82 E.01516
G1 X101.514 Y91.2 E.01038
G1 X101.972 Y91.824 E.01473
G1 X102.299 Y92.511 E.01449
G3 X102.541 Y93.674 I-4.991 J1.644 E.02266
G1 X102.541 Y103.626 E.18946
G3 X102.345 Y104.661 I-4.033 J-.225 E.0201
G1 X102.032 Y105.372 E.01479
G1 X101.736 Y105.83 E.01038
G1 X101.214 Y106.4 E.01472
G1 X100.573 Y106.874 E.01517
G1 X100.087 Y107.122 E.01038
G1 X99.349 Y107.363 E.01479
G3 X98.726 Y107.433 I-.762 J-4 E.01194
G1 X88.778 Y107.433 E.18939
; LINE_WIDTH: 0.4192
G1 X88.394 Y107.389 E.00744
; LINE_WIDTH: 0.421678
G1 X88.009 Y107.345 E.00748
G1 X87.267 Y107.055 E.01544
G1 X86.584 Y106.645 E.01542
G3 X85.517 Y105.46 I2.746 J-3.546 E.03104
G1 X85.201 Y104.789 E.01435
G3 X84.959 Y103.626 I4.995 J-1.645 E.02303
G1 X84.953 Y93.876 E.18875
G1 X84.997 Y93.319 E.01082
G1 X85.151 Y92.655 E.01318
G1 X85.352 Y92.148 E.01056
G1 X85.753 Y91.487 E.01496
G1 X86.289 Y90.897 E.01543
G1 X86.717 Y90.559 E.01056
G1 X87.398 Y90.185 E.01503
G1 X88.152 Y89.937 E.01537
; LINE_WIDTH: 0.401795
G3 X88.975 Y89.863 I1.022 J6.719 E.01521
G1 X98.465 Y89.863 E.17446
M204 S10000
G1 X98.525 Y89.488 F42000
; LINE_WIDTH: 0.415811
G1 F13796
M204 S6000
G1 X88.975 Y89.488 E.18211
G3 X83.832 Y89.497 I-2.93 J-200.941 E.0981
G1 X83.65 Y89.552 E.00361
G1 X83.597 Y89.757 E.00406
G1 X83.597 Y107.568 E.33967
G1 X83.652 Y107.75 E.00361
G1 X83.858 Y107.803 E.00406
G1 X87.131 Y107.803 E.06243
G3 X88.778 Y107.811 I.663 J33.117 E.03141
G1 X98.726 Y107.811 E.18972
G3 X100.094 Y107.803 I.783 J16.996 E.0261
G1 X103.668 Y107.803 E.06816
G1 X103.85 Y107.748 E.00361
G1 X103.903 Y107.542 E.00406
G1 X103.903 Y89.756 E.33921
G1 X103.849 Y89.551 E.00403
G1 X103.694 Y89.499 E.00312
G3 X98.585 Y89.489 I-2.152 J-210.577 E.09745
M204 S10000
G1 X84.841 Y90.663 F42000
; LINE_WIDTH: 0.485052
G1 F13796
M204 S6000
G2 X84.838 Y90.762 I-.029 J.049 E.00529
M204 S10000
G1 X84.385 Y92.468 F42000
; LINE_WIDTH: 0.419992
G1 F13796
M204 S6000
G1 X84.624 Y91.846 E.01284
G1 X85.083 Y91.071 E.01736
G1 X85.794 Y90.286 E.02042
G1 X84.385 Y90.286 E.02714
G1 X84.385 Y92.408 E.04092
M204 S10000
G1 X84.515 Y93.876 F42000
; LINE_WIDTH: 0.522187
G1 F13796
M204 S6000
G1 X84.555 Y93.216 E.01605
; LINE_WIDTH: 0.518084
G1 X84.626 Y92.999 E.00548
; LINE_WIDTH: 0.478847
G1 X84.696 Y92.783 E.00505
; LINE_WIDTH: 0.420458
G3 X84.988 Y91.997 I7.09 J2.186 E.01618
G1 X85.418 Y91.279 E.01615
G1 X86.001 Y90.628 E.01687
G1 X86.477 Y90.246 E.01178
G1 X87.111 Y89.892 E.01403
G1 X83.991 Y89.891 E.06021
G1 X83.991 Y92.477 E.0499
; LINE_WIDTH: 0.439611
G1 X84.011 Y92.704 E.00461
; LINE_WIDTH: 0.478847
G1 X84.03 Y92.931 E.00505
; LINE_WIDTH: 0.51033
G1 X84.05 Y93.158 E.0054
G2 X84.035 Y93.876 I23.758 J.872 E.01702
G1 X84.036 Y103.627 E.23101
G1 X84.054 Y104.246 E.01467
; LINE_WIDTH: 0.524184
G1 X84.033 Y104.468 E.00544
; LINE_WIDTH: 0.482507
G1 X84.012 Y104.69 E.00498
; LINE_WIDTH: 0.420495
G1 X83.991 Y104.912 E.00431
G1 X83.991 Y107.409 E.04819
G1 X87.097 Y107.409 E.05994
G1 X86.376 Y106.98 E.01619
G3 X85.189 Y105.679 I2.966 J-3.898 E.03418
G1 X84.843 Y104.953 E.01551
; LINE_WIDTH: 0.442122
G1 X84.73 Y104.651 E.00657
; LINE_WIDTH: 0.486382
G1 X84.617 Y104.349 E.00727
; LINE_WIDTH: 0.509609
G1 X84.571 Y104.212 E.00341
G1 X84.52 Y103.627 E.0139
G1 X84.515 Y93.936 E.22925
M204 S10000
G1 X85.347 Y93.876 F42000
; LINE_WIDTH: 0.419992
G1 F13796
M204 S6000
G1 X85.381 Y93.408 E.00904
G1 X85.535 Y92.744 E.01313
G1 X85.731 Y92.27 E.00989
G1 X86.088 Y91.695 E.01305
G1 X86.577 Y91.167 E.01387
G1 X86.984 Y90.854 E.00989
G1 X87.584 Y90.533 E.01312
G1 X88.269 Y90.322 E.01381
G3 X88.975 Y90.247 I1.011 J6.224 E.01371
G1 X98.525 Y90.247 E.18406
G1 X98.996 Y90.281 E.00911
G1 X99.656 Y90.435 E.01306
G1 X100.306 Y90.725 E.01373
G1 X100.894 Y91.141 E.01387
G1 X101.256 Y91.503 E.00988
G1 X101.652 Y92.054 E.01307
G1 X101.941 Y92.675 E.01321
G3 X102.146 Y93.674 I-3.381 J1.217 E.01972
G1 X102.146 Y103.626 E.19183
G3 X101.673 Y105.21 I-3.975 J-.325 E.03209
G1 X101.388 Y105.636 E.00988
G1 X100.926 Y106.131 E.01306
G1 X100.343 Y106.554 E.01388
G1 X99.883 Y106.78 E.00988
G1 X99.232 Y106.979 E.01313
G1 X98.726 Y107.046 E.00983
G1 X88.778 Y107.046 E.19176
G1 X88.077 Y106.934 E.01368
G1 X87.405 Y106.686 E.0138
G1 X86.792 Y106.31 E.01387
G3 X85.829 Y105.213 I2.508 J-3.173 E.02828
G1 X85.559 Y104.625 E.01248
G3 X85.354 Y103.626 I3.38 J-1.217 E.01972
G1 X85.347 Y93.936 E.18679
M204 S10000
G1 X84.385 Y104.826 F42000
; LINE_WIDTH: 0.419992
G1 F13796
M204 S6000
G1 X84.385 Y107.015 E.04219
G1 X85.798 Y107.015 E.02722
G1 X85.22 Y106.414 E.01606
G1 X84.861 Y105.898 E.01212
G1 X84.484 Y105.117 E.0167
G1 X84.405 Y104.883 E.00478
M204 S10000
G1 X84.841 Y106.538 F42000
; LINE_WIDTH: 0.484972
G1 F13796
M204 S6000
G2 X84.838 Y106.638 I-.029 J.049 E.00529
M204 S10000
G1 X83.858 Y108.197 F42000
; LINE_WIDTH: 0.419992
G1 F13796
M204 S6000
G1 X103.705 Y108.197 E.38256
G1 X103.959 Y108.15 E.00498
G2 X104.248 Y107.862 I-.205 J-.496 E.00807
G1 X104.297 Y107.542 E.00624
M73 P28 R8
G1 X104.297 Y89.756 E.34285
G1 X104.25 Y89.442 E.00612
G2 X103.955 Y89.148 I-.501 J.208 E.00822
G1 X103.646 Y89.105 E.00601
G1 X83.795 Y89.103 E.38264
G1 X83.542 Y89.15 E.00498
G2 X83.252 Y89.438 I.205 J.497 E.00807
G1 X83.203 Y89.757 E.00623
G1 X83.203 Y107.605 E.34401
G1 X83.25 Y107.858 E.00497
G2 X83.798 Y108.188 I.526 J-.253 E.01305
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X83.538 Y108.148 E-.10017
G1 X83.367 Y108.033 E-.07814
G1 X83.25 Y107.858 E-.08003
G1 X83.203 Y107.605 E-.09798
G1 X83.203 Y106.542 E-.40368
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X85.79 Y99.362 Z1.92 F42000
G1 X91.107 Y84.607 Z1.92
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13796
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F13796
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z1.92 F42000
G1 X103.14 Y85.44 Z1.92
G1 Z1.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z1.92 F42000
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13796
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F13796
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.987 Y83.018 Z1.92 F42000
G1 X85.456 Y83.553 Z1.92
G1 Z1.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13796
M204 S6000
G1 X76.544 Y83.553 E.18487
G3 X75.447 Y82.456 I-.01 J-1.087 E.03583
G1 X75.447 Y73.544 E.18487
G3 X76.544 Y72.447 I1.087 J-.01 E.03583
G1 X85.469 Y72.447 E.18512
G3 X86.553 Y73.544 I-.001 J1.086 E.03558
G1 X86.553 Y82.456 E.18487
G3 X85.516 Y83.552 I-1.087 J.01 E.03459
M204 S10000
G1 X85.463 Y83.978 F42000
G1 F13796
M204 S6000
G1 X76.537 Y83.978 E.18516
G3 X75.022 Y82.463 I-.001 J-1.513 E.04935
G1 X75.022 Y73.537 E.18516
G3 X76.537 Y72.022 I1.513 J-.002 E.04935
G1 X85.475 Y72.023 E.18541
G3 X86.978 Y73.537 I-.01 J1.512 E.0491
G1 X86.978 Y82.463 E.18516
G3 X85.523 Y83.976 I-1.513 J.002 E.04811
M204 S250
G1 X85.47 Y84.387 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.53 Y84.387 E.17232
G3 X74.613 Y82.47 I.007 J-1.924 E.05798
G1 X74.613 Y73.53 E.17232
G3 X76.53 Y71.613 I1.924 J.007 E.05798
G1 X85.482 Y71.614 E.17256
G3 X87.387 Y73.53 I-.018 J1.923 E.05775
G1 X87.387 Y82.47 E.17232
G3 X85.53 Y84.386 I-1.924 J-.007 E.05683
; WIPE_START
M204 S6000
G1 X83.53 Y84.386 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.19 Y81.566 Z1.92 F42000
G1 Z1.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13796
M204 S6000
G3 X86.092 Y82.831 I-2.531 J.441 E.0266
G3 X85.792 Y83.11 I-.729 J-.485 E.00858
G2 X82.764 Y83.19 I-1.475 J1.498 E.07015
G1 X78.604 Y83.19 E.08629
G2 X75.911 Y82.83 I-1.567 J1.467 E.06104
G3 X75.81 Y82.439 I.693 J-.387 E.00846
G1 X75.81 Y79.845 E.05382
G3 X78.724 Y79.117 I1.891 J1.376 E.06766
G2 X80.09 Y80.377 I119.976 J-128.71 E.03853
G2 X82.821 Y80.132 I1.226 J-1.687 E.06207
G3 X85.097 Y78.851 I2.417 J1.632 E.05617
G3 X86.189 Y79.274 I-.072 J1.81 E.02475
G1 X86.188 Y76.201 E.06375
G2 X83.276 Y75.476 I-1.894 J1.394 E.06752
G3 X81.91 Y76.735 I-119.799 J-128.517 E.03853
G3 X79.179 Y76.491 I-1.226 J-1.687 E.06207
G2 X76.903 Y75.21 I-2.417 J1.632 E.05617
G2 X75.81 Y75.634 I.072 J1.809 E.02478
G3 X75.817 Y73.439 I17.706 J-1.039 E.04556
G3 X76.488 Y72.812 I.722 J.101 E.02059
G1 X79.757 Y72.812 E.0678
G2 X82.366 Y73.241 I1.593 J-1.537 E.05878
G2 X82.857 Y72.811 I-1.845 J-2.602 E.01358
G1 X84.554 Y72.81 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X82.857 Y72.811 E-.64486
G1 X82.629 Y73.01 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 13/73
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.92 I-1.207 J.154 P1  F42000
G1 X86.797 Y105.779 Z1.92
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
G1 F13791
M204 S6000
G1 X86.711 Y105.689 E.0026
G3 X85.757 Y103.417 I2.305 J-2.305 E.05241
G1 X85.757 Y93.883 E.19777
G3 X88.983 Y90.657 I3.259 J.033 E.10483
G1 X98.517 Y90.657 E.19777
G3 X101.743 Y93.883 I-.033 J3.259 E.10483
G1 X101.743 Y103.417 E.19777
G3 X98.517 Y106.643 I-3.259 J-.033 E.10483
G1 X88.983 Y106.643 E.19777
G3 X86.866 Y105.834 I.033 J-3.259 E.04802
G1 X86.844 Y105.817 E.00057
M204 S10000
G1 X87.083 Y105.461 F42000
G1 F13791
M204 S6000
G1 X87.01 Y105.389 E.00212
G3 X86.181 Y103.41 I2.004 J-2.003 E.04565
G1 X86.181 Y93.89 E.19748
G3 X88.99 Y91.081 I2.833 J.024 E.09131
G1 X98.51 Y91.081 E.19748
G3 X101.319 Y93.89 I-.024 J2.833 E.09131
G1 X101.319 Y103.41 E.19748
G3 X98.51 Y106.219 I-2.833 J-.024 E.09131
G1 X88.99 Y106.219 E.19748
G3 X87.287 Y105.632 I.024 J-2.833 E.03801
G1 X87.129 Y105.5 E.00428
M204 S250
G1 X87.337 Y105.138 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X87.299 Y105.101 E.00102
G3 X86.59 Y103.404 I1.713 J-1.713 E.03637
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X87.664 Y105.4 I.016 J-2.422 E.02726
G1 X87.384 Y105.175 E.00692
; WIPE_START
M204 S6000
G1 X87.299 Y105.101 E-.0428
G1 X86.996 Y104.739 E-.17934
G1 X86.774 Y104.323 E-.17925
G1 X86.636 Y103.87 E-.17983
G1 X86.59 Y103.404 E-.1782
G1 X86.59 Y103.402 E-.00059
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.767 Y108.607 Z2.04 F42000
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13791
M204 S6000
G3 X82.793 Y107.633 I-.011 J-.963 E.03182
G1 X82.793 Y89.667 E.37266
G3 X83.767 Y88.693 I.963 J-.011 E.03182
G1 X103.8 Y88.696 E.41553
G3 X104.707 Y89.667 I-.051 J.957 E.03045
G1 X104.707 Y107.633 E.37266
G3 X103.733 Y108.607 I-.963 J.011 E.03182
G1 X83.827 Y108.607 E.4129
M204 S10000
G1 X83.76 Y109.031 F42000
G1 F13791
M204 S6000
G3 X82.369 Y107.64 I-.002 J-1.389 E.04533
G1 X82.369 Y89.66 E.37295
G3 X83.76 Y88.269 I1.389 J-.002 E.04533
G1 X103.826 Y88.272 E.41623
G3 X105.131 Y89.66 I-.078 J1.38 E.04359
G1 X105.131 Y107.64 E.37295
G3 X103.74 Y109.031 I-1.389 J.002 E.04533
G1 X83.82 Y109.031 E.41319
M204 S250
G1 X83.753 Y109.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X81.96 Y107.647 I.006 J-1.8 E.05425
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.006 E.05425
G1 X103.852 Y87.863 E.38741
G3 X105.54 Y89.653 I-.104 J1.789 E.05228
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.006 E.05425
M73 P29 R8
G1 X83.813 Y109.44 E.38423
; WIPE_START
M204 S6000
G1 X83.4 Y109.405 E-.15767
G1 X83.065 Y109.304 E-.13298
G1 X82.756 Y109.138 E-.13333
G1 X82.484 Y108.916 E-.13335
G1 X82.261 Y108.644 E-.13366
G1 X82.176 Y108.483 E-.06902
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.04 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 13 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer13 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.716 Y106.538
G1 Z1.64
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.485132
G1 F13791
M204 S6000
G2 X102.714 Y106.637 I-.029 J.049 E.00529
M204 S10000
G1 X103.115 Y104.793 F42000
; LINE_WIDTH: 0.419992
G1 F13791
M204 S6000
G1 X102.942 Y105.306 E.01044
G3 X102.347 Y106.331 I-4.525 J-1.942 E.02289
G1 X101.703 Y107.015 E.0181
G1 X103.115 Y107.015 E.02721
G1 X103.115 Y104.853 E.04166
M204 S10000
G1 X102.98 Y103.626 F42000
; LINE_WIDTH: 0.527292
G1 F13791
M204 S6000
G1 X102.93 Y104.207 E.01431
; LINE_WIDTH: 0.523934
G1 X102.835 Y104.467 E.00672
; LINE_WIDTH: 0.482357
G1 X102.74 Y104.726 E.00616
; LINE_WIDTH: 0.420625
G3 X102.064 Y106.049 I-4.719 J-1.578 E.02879
G1 X101.502 Y106.669 E.01616
G1 X100.803 Y107.194 E.01687
G1 X100.398 Y107.409 E.00885
G1 X103.509 Y107.409 E.06006
G1 X103.509 Y105.112 E.04435
; LINE_WIDTH: 0.439622
G1 X103.489 Y104.782 E.00668
; LINE_WIDTH: 0.478882
G1 X103.47 Y104.453 E.00731
; LINE_WIDTH: 0.510686
G3 X103.464 Y103.626 I14.168 J-.511 E.01961
G1 X103.464 Y93.674 E.23596
G1 X103.446 Y93.055 E.01468
; LINE_WIDTH: 0.524142
G1 X103.467 Y92.847 E.0051
; LINE_WIDTH: 0.482482
G1 X103.488 Y92.638 E.00467
; LINE_WIDTH: 0.420458
G1 X103.509 Y92.43 E.00404
G1 X103.509 Y89.893 E.04896
G1 X100.382 Y89.893 E.06035
G1 X100.776 Y90.09 E.0085
G1 X101.346 Y90.495 E.0135
G1 X101.959 Y91.119 E.01687
G1 X102.425 Y91.829 E.0164
G1 X102.682 Y92.407 E.01221
; LINE_WIDTH: 0.43772
G1 X102.779 Y92.684 E.00592
; LINE_WIDTH: 0.473175
G1 X102.876 Y92.961 E.00643
; LINE_WIDTH: 0.50442
G1 X102.903 Y93.025 E.00162
; LINE_WIDTH: 0.510981
G1 X102.929 Y93.089 E.00164
G1 X102.98 Y93.674 E.01393
G1 X102.98 Y103.566 E.23468
M204 S10000
G1 X103.11 Y92.43 F42000
; LINE_WIDTH: 0.419992
G1 F13791
M204 S6000
G2 X103.115 Y90.288 I-161.105 J-1.403 E.0413
G1 X101.705 Y90.287 E.02717
G1 X102.246 Y90.849 E.01503
G1 X102.759 Y91.62 E.01785
G3 X103.089 Y92.374 I-5.185 J2.718 E.01588
M204 S10000
G1 X102.717 Y90.664 F42000
; LINE_WIDTH: 0.484172
G1 F13791
M204 S6000
G2 X102.714 Y90.763 I-.029 J.049 E.00527
M204 S10000
G1 X98.525 Y89.863 F42000
; LINE_WIDTH: 0.419865
G1 F13791
M204 S6000
G1 X99.087 Y89.895 E.01085
G1 X99.746 Y90.051 E.01306
G1 X100.448 Y90.355 E.01474
G1 X101.118 Y90.817 E.01568
G1 X101.671 Y91.388 E.01533
G1 X102.091 Y92.038 E.01491
G3 X102.541 Y93.674 I-3.57 J1.861 E.03294
G1 X102.541 Y103.626 E.19176
G1 X102.477 Y104.148 E.01013
G1 X102.268 Y104.872 E.01452
G3 X101.736 Y105.83 I-3.69 J-1.422 E.02118
G1 X101.214 Y106.4 E.0149
G1 X100.573 Y106.874 E.01535
G1 X100.084 Y107.124 E.01058
; LINE_WIDTH: 0.416004
G1 X99.59 Y107.313 E.01011
G1 X98.722 Y107.433 E.01671
G1 X88.774 Y107.433 E.18982
G1 X88.251 Y107.385 E.01002
G1 X87.506 Y107.159 E.01486
G1 X87.01 Y106.924 E.01047
G1 X86.374 Y106.477 E.01484
G1 X85.826 Y105.908 E.01506
G1 X85.409 Y105.262 E.01468
G3 X84.959 Y103.626 I3.574 J-1.861 E.0326
G1 X84.953 Y93.876 E.18605
G1 X84.997 Y93.318 E.01066
G1 X85.15 Y92.658 E.01293
G1 X85.468 Y91.928 E.01519
G1 X85.766 Y91.467 E.01048
G1 X86.29 Y90.897 E.01477
G1 X86.924 Y90.428 E.01506
G1 X87.64 Y90.09 E.01511
G1 X88.167 Y89.932 E.01049
G1 X88.917 Y89.865 E.01436
; LINE_WIDTH: 0.400375
G1 X98.465 Y89.863 E.17488
M204 S10000
G1 X98.525 Y89.489 F42000
; LINE_WIDTH: 0.412931
G1 F13791
M204 S6000
G1 X88.976 Y89.488 E.18076
G3 X87.658 Y89.497 I-.785 J-17.482 E.02494
G1 X83.832 Y89.497 E.07244
G1 X83.651 Y89.551 E.00357
G1 X83.597 Y89.756 E.00401
G1 X83.597 Y107.568 E.33719
G1 X83.651 Y107.749 E.00357
G1 X83.856 Y107.803 E.004
G3 X88.774 Y107.811 I1.774 J423.825 E.0931
G1 X98.722 Y107.811 E.18832
; LINE_WIDTH: 0.419272
G1 X99.126 Y107.796 E.00777
; LINE_WIDTH: 0.420962
G3 X100.12 Y107.803 I.449 J6.577 E.01923
G1 X103.668 Y107.803 E.06856
G1 X103.849 Y107.749 E.00364
G1 X103.903 Y107.544 E.00409
G1 X103.903 Y89.737 E.34408
G1 X103.855 Y89.557 E.0036
G1 X103.665 Y89.499 E.00384
G2 X99.132 Y89.501 I-1.996 J644.704 E.08759
; LINE_WIDTH: 0.412877
G1 X98.585 Y89.489 E.01037
M204 S10000
G1 X84.841 Y90.663 F42000
; LINE_WIDTH: 0.484912
G1 F13791
M204 S6000
G2 X84.838 Y90.762 I-.029 J.049 E.00529
M204 S10000
G1 X84.385 Y92.47 F42000
; LINE_WIDTH: 0.419992
G1 F13791
M204 S6000
G1 X84.749 Y91.603 E.01811
G1 X85.11 Y91.029 E.01307
G1 X85.797 Y90.286 E.01951
G1 X84.385 Y90.286 E.0272
G1 X84.385 Y92.41 E.04094
M204 S10000
G1 X84.515 Y93.876 F42000
; LINE_WIDTH: 0.522192
G1 F13791
M204 S6000
G1 X84.555 Y93.216 E.01606
; LINE_WIDTH: 0.518092
G1 X84.626 Y93 E.00546
; LINE_WIDTH: 0.478852
G1 X84.696 Y92.785 E.00502
; LINE_WIDTH: 0.420455
G1 X84.766 Y92.569 E.00438
G1 X85.108 Y91.766 E.01685
G1 X85.438 Y91.248 E.01184
G1 X86.002 Y90.627 E.01619
G1 X86.694 Y90.108 E.0167
G1 X87.124 Y89.892 E.00928
G1 X83.991 Y89.891 E.06045
G1 X83.991 Y92.48 E.04996
; LINE_WIDTH: 0.439612
G1 X84.011 Y92.706 E.00459
; LINE_WIDTH: 0.478852
G1 X84.03 Y92.932 E.00502
; LINE_WIDTH: 0.510327
G1 X84.05 Y93.158 E.00537
G2 X84.035 Y93.876 I23.729 J.872 E.01703
G1 X84.036 Y103.627 E.23101
G1 X84.054 Y104.245 E.01465
; LINE_WIDTH: 0.524134
G1 X84.033 Y104.453 E.0051
; LINE_WIDTH: 0.482477
G1 X84.012 Y104.662 E.00468
; LINE_WIDTH: 0.420459
G1 X83.991 Y104.87 E.00404
G1 X83.991 Y107.409 E.04899
G1 X87.102 Y107.409 E.06003
G1 X86.697 Y107.194 E.00885
G1 X86.144 Y106.797 E.01314
G1 X85.538 Y106.177 E.01672
G1 X85.075 Y105.471 E.01631
G1 X84.818 Y104.893 E.0122
; LINE_WIDTH: 0.44286
G1 X84.716 Y104.617 E.006
; LINE_WIDTH: 0.488595
G1 X84.614 Y104.341 E.00666
; LINE_WIDTH: 0.509613
G1 X84.571 Y104.211 E.00324
G1 X84.52 Y103.627 E.01388
G1 X84.515 Y93.936 E.22925
M204 S10000
G1 X85.347 Y93.876 F42000
; LINE_WIDTH: 0.419992
G1 F13791
M204 S6000
G1 X85.381 Y93.407 E.00905
G1 X85.534 Y92.747 E.01306
G1 X85.827 Y92.091 E.01386
G1 X86.114 Y91.661 E.00996
G1 X86.577 Y91.167 E.01306
G1 X87.154 Y90.748 E.01373
G1 X87.803 Y90.449 E.01379
G1 X88.288 Y90.317 E.00968
G3 X88.976 Y90.247 I1.012 J6.591 E.01332
G1 X98.525 Y90.247 E.18406
G1 X98.996 Y90.281 E.00912
G1 X99.656 Y90.435 E.01306
G1 X100.286 Y90.715 E.01329
G1 X100.89 Y91.138 E.01422
G1 X101.384 Y91.658 E.01382
G1 X101.757 Y92.247 E.01344
G3 X102.146 Y93.674 I-3.685 J1.772 E.02867
G1 X102.146 Y103.626 E.19183
G1 X102.079 Y104.127 E.00975
G1 X101.89 Y104.759 E.0127
G3 X100.926 Y106.131 I-3.67 J-1.554 E.03257
G1 X100.343 Y106.554 E.01387
G3 X98.722 Y107.046 I-1.923 J-3.413 E.03291
G1 X88.774 Y107.046 E.19176
G1 X88.272 Y106.979 E.00976
G1 X87.62 Y106.782 E.01314
G1 X87.157 Y106.554 E.00996
G1 X86.603 Y106.156 E.01313
G1 X86.114 Y105.639 E.01373
G1 X85.743 Y105.053 E.01337
G3 X85.354 Y103.626 I3.687 J-1.773 E.02866
G1 X85.347 Y93.936 E.18679
M204 S10000
G1 X84.39 Y104.87 F42000
G1 F13791
M204 S6000
G2 X84.385 Y107.015 I159.342 J1.404 E.04134
G1 X85.797 Y107.015 E.0272
G1 X85.25 Y106.447 E.01519
G1 X84.74 Y105.68 E.01775
G3 X84.411 Y104.926 I5.224 J-2.735 E.01587
M204 S10000
G1 X84.841 Y106.538 F42000
; LINE_WIDTH: 0.485232
G1 F13791
M204 S6000
G2 X84.838 Y106.637 I-.029 J.049 E.0053
M204 S10000
G1 X83.856 Y108.197 F42000
; LINE_WIDTH: 0.419992
G1 F13791
M204 S6000
G1 X103.705 Y108.197 E.3826
G1 X103.958 Y108.15 E.00497
G2 X104.25 Y107.858 I-.207 J-.498 E.00816
G1 X104.297 Y107.544 E.00612
G1 X104.297 Y89.737 E.34323
G1 X104.265 Y89.481 E.00499
G2 X103.99 Y89.165 I-.516 J.171 E.00829
G1 X103.665 Y89.105 E.00638
G1 X83.795 Y89.103 E.38299
G1 X83.541 Y89.15 E.00498
G2 X83.25 Y89.442 I.207 J.498 E.00815
G1 X83.203 Y89.756 E.00613
G1 X83.203 Y107.605 E.34404
G1 X83.25 Y107.859 E.00498
G2 X83.796 Y108.188 I.527 J-.256 E.01301
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X83.542 Y108.15 E-.09782
G1 X83.367 Y108.033 E-.07986
G1 X83.25 Y107.859 E-.07991
G1 X83.203 Y107.605 E-.09809
G1 X83.203 Y106.541 E-.40432
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X85.79 Y99.36 Z2.04 F42000
G1 X91.107 Y84.607 Z2.04
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13791
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F13791
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.04 F42000
G1 X103.14 Y85.44 Z2.04
G1 Z1.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.04 F42000
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13791
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F13791
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.986 Y83.012 Z2.04 F42000
G1 X85.45 Y83.54 Z2.04
G1 Z1.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F13791
M204 S6000
G1 X76.551 Y83.54 E.18459
G3 X75.46 Y82.45 I-.01 J-1.08 E.03561
G1 X75.46 Y73.551 E.18459
G3 X76.55 Y72.46 I1.08 J-.01 E.03561
G1 X85.464 Y72.461 E.18489
G3 X86.54 Y73.55 I-.003 J1.079 E.03531
G1 X86.54 Y82.449 E.18459
G3 X85.51 Y83.539 I-1.08 J.01 E.03437
M204 S10000
G1 X85.457 Y83.964 F42000
G1 F13791
M204 S6000
G1 X76.543 Y83.964 E.18488
G3 X75.036 Y82.457 I-.002 J-1.506 E.04913
G1 X75.036 Y73.543 E.18488
G3 X76.543 Y72.036 I1.506 J-.002 E.04913
M73 P30 R8
G1 X85.471 Y72.036 E.18518
G3 X86.964 Y73.543 I-.012 J1.505 E.04883
G1 X86.964 Y82.457 E.18488
G3 X85.516 Y83.963 I-1.506 J.002 E.04789
M204 S250
G1 X85.463 Y84.373 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.537 Y84.373 E.17206
G3 X74.627 Y82.463 I.007 J-1.917 E.05778
G1 X74.627 Y73.537 E.17206
G3 X76.537 Y71.627 I1.917 J.007 E.05778
G1 X85.477 Y71.627 E.17234
G3 X87.373 Y73.537 I-.02 J1.916 E.0575
G1 X87.373 Y82.463 E.17206
G3 X85.523 Y84.372 I-1.917 J-.007 E.05662
; WIPE_START
M204 S6000
G1 X83.523 Y84.372 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.177 Y81.485 Z2.04 F42000
G1 Z1.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F13791
M204 S6000
G3 X86.137 Y82.694 I-3.382 J.494 E.02522
G3 X85.84 Y83.065 I-1.125 J-.595 E.00991
G2 X82.937 Y83.177 I-1.393 J1.592 E.06644
G1 X78.705 Y83.177 E.08778
G2 X75.975 Y82.893 I-1.542 J1.555 E.06153
G3 X75.823 Y82.433 I.824 J-.526 E.01015
G1 X75.823 Y79.719 E.05628
G3 X79.179 Y79.638 I1.713 J1.403 E.07903
G2 X81.91 Y80.646 I2.094 J-1.47 E.06424
G2 X83.276 Y79.55 I-2.138 J-4.063 E.03654
G3 X86.176 Y79.384 I1.54 J1.501 E.06614
G1 X86.175 Y76.076 E.06863
G2 X82.821 Y75.996 I-1.711 J1.404 E.07897
G3 X80.09 Y77.004 I-2.094 J-1.471 E.06424
G3 X78.724 Y75.908 I2.139 J-4.063 E.03654
G2 X75.823 Y75.744 I-1.54 J1.501 E.06617
G3 X75.83 Y73.446 I18.527 J-1.091 E.04769
G3 X76.498 Y72.826 I.715 J.1 E.02046
G1 X79.656 Y72.825 E.06551
G2 X82.704 Y72.824 I1.523 J-1.516 E.07027
G1 X84.401 Y72.824 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X82.704 Y72.824 E-.64486
G1 X82.477 Y73.025 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 14/73
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.04 I-1.206 J.166 P1  F42000
G1 X86.777 Y104.321 Z2.04
G1 Z1.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X86.59 Y103.404 I2.235 J-.933 E.01816
G1 X86.59 Y93.896 E.18326
G3 X88.996 Y91.49 I2.422 J.016 E.07273
G1 X98.504 Y91.49 E.18326
G3 X100.91 Y93.896 I-.016 J2.422 E.07273
G1 X100.91 Y103.404 E.18326
G3 X98.504 Y105.81 I-2.422 J-.016 E.07273
G1 X88.996 Y105.81 E.18326
G3 X86.801 Y104.376 I.016 J-2.422 E.05342
; WIPE_START
M204 S6000
G1 X86.636 Y103.87 E-.20204
G1 X86.59 Y103.404 E-.17819
G1 X86.59 Y102.404 E-.37978
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.753 Y109.44 Z2.16 F42000
G1 Z1.76
G1 E.8 F1800
G1 F12000
M204 S5000
G3 X81.96 Y107.647 I.007 J-1.8 E.05424
G1 X81.96 Y89.653 E.34683
G3 X83.753 Y87.86 I1.8 J.007 E.05424
G1 X103.86 Y87.864 E.38757
G3 X105.54 Y89.653 I-.112 J1.789 E.05212
G1 X105.54 Y107.647 E.34683
G3 X103.747 Y109.44 I-1.8 J-.007 E.05424
G1 X83.813 Y109.44 E.38423
; WIPE_START
M204 S6000
G1 X83.401 Y109.405 E-.15734
G1 X83.065 Y109.304 E-.13336
G1 X82.756 Y109.138 E-.13325
G1 X82.484 Y108.915 E-.13355
G1 X82.262 Y108.644 E-.13318
G1 X82.176 Y108.483 E-.06932
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.16 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 14 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer14 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X105.275 Y108.033
G1 Z1.76
G1 E.8 F1800
; FEATURE: Top surface
G1 F12000
M204 S2000
G1 X104.133 Y109.175 E.03114
G1 X103.527 Y109.223
G1 X105.323 Y107.427 E.04897
G1 X105.323 Y106.869
G1 X102.969 Y109.223 E.06416
G1 X102.412 Y109.223
G1 X105.323 Y106.312 E.07936
G1 X105.323 Y105.754
G1 X101.854 Y109.223 E.09456
G1 X101.297 Y109.223
G1 X105.323 Y105.197 E.10976
G1 X105.323 Y104.639
G1 X100.739 Y109.223 E.12496
G1 X100.182 Y109.223
G1 X105.323 Y104.082 E.14016
G1 X105.323 Y103.524
G1 X99.624 Y109.223 E.15535
G1 X99.067 Y109.223
G1 X105.323 Y102.967 E.17055
G1 X105.323 Y102.409
G1 X98.509 Y109.223 E.18575
G1 X97.952 Y109.223
G1 X105.323 Y101.852 E.20095
G1 X105.323 Y101.294
G1 X97.394 Y109.223 E.21615
G1 X96.836 Y109.223
G1 X105.323 Y100.736 E.23135
G1 X105.323 Y100.179
G1 X100.753 Y104.749 E.12459
G1 X101.085 Y103.859
G1 X105.323 Y99.621 E.11552
G1 X105.323 Y99.064
G1 X101.127 Y103.26 E.11439
G1 X101.127 Y102.703
G1 X105.323 Y98.506 E.11439
G1 X105.323 Y97.949
G1 X101.127 Y102.145 E.11439
G1 X101.127 Y101.588
G1 X105.323 Y97.391 E.11439
G1 X105.323 Y96.834
G1 X101.127 Y101.03 E.11439
G1 X101.127 Y100.472
G1 X105.323 Y96.276 E.11439
G1 X105.323 Y95.719
G1 X101.127 Y99.915 E.11439
G1 X101.127 Y99.357
G1 X105.323 Y95.161 E.11439
G1 X105.323 Y94.604
G1 X101.127 Y98.8 E.11439
G1 X101.127 Y98.242
G1 X105.323 Y94.046 E.11439
G1 X105.323 Y93.488
G1 X101.127 Y97.685 E.11439
G1 X101.127 Y97.127
G1 X105.323 Y92.931 E.11439
G1 X105.323 Y92.373
G1 X101.127 Y96.57 E.11439
G1 X101.127 Y96.012
G1 X105.323 Y91.816 E.11439
G1 X105.323 Y91.258
G1 X101.127 Y95.455 E.11439
G1 X101.127 Y94.897
G1 X105.323 Y90.701 E.11439
G1 X105.323 Y90.143
G1 X101.127 Y94.34 E.11439
G1 X101.123 Y93.786
G1 X105.321 Y89.588 E.11443
G1 X105.231 Y89.121
G1 X101.055 Y93.296 E.11382
G1 X100.918 Y92.875
G1 X105.041 Y88.753 E.11239
G1 X104.777 Y88.459
G1 X100.727 Y92.509 E.1104
M73 P31 R8
G1 X100.491 Y92.187
G1 X104.441 Y88.237 E.10768
G1 X104.02 Y88.101
G1 X100.212 Y91.909 E.10379
G1 X99.891 Y91.673
G1 X103.487 Y88.077 E.09803
G1 X102.929 Y88.077
G1 X99.524 Y91.482 E.09281
G1 X99.104 Y91.345
G1 X102.372 Y88.077 E.08908
G1 X101.814 Y88.077
G1 X98.614 Y91.277 E.08723
G1 X98.06 Y91.273
G1 X101.257 Y88.077 E.08713
G1 X100.699 Y88.077
G1 X97.503 Y91.273 E.08713
G1 X96.945 Y91.273
G1 X100.142 Y88.077 E.08713
G1 X99.584 Y88.077
G1 X96.388 Y91.273 E.08713
G1 X95.83 Y91.273
G1 X99.026 Y88.077 E.08713
G1 X98.469 Y88.077
G1 X95.273 Y91.273 E.08713
G1 X94.715 Y91.273
G1 X97.911 Y88.077 E.08713
G1 X97.354 Y88.077
G1 X94.158 Y91.273 E.08713
G1 X93.6 Y91.273
G1 X96.796 Y88.077 E.08713
G1 X96.239 Y88.077
G1 X93.042 Y91.273 E.08713
G1 X92.485 Y91.273
G1 X95.681 Y88.077 E.08713
G1 X95.124 Y88.077
G1 X91.927 Y91.273 E.08713
G1 X91.37 Y91.273
G1 X94.566 Y88.077 E.08713
G1 X94.009 Y88.077
G1 X90.812 Y91.273 E.08713
G1 X90.255 Y91.273
G1 X93.451 Y88.077 E.08713
G1 X92.894 Y88.077
G1 X89.697 Y91.273 E.08713
G1 X89.14 Y91.273
G1 X92.336 Y88.077 E.08713
G1 X91.778 Y88.077
G1 X88.541 Y91.315 E.08826
G1 X87.65 Y91.648
G1 X91.221 Y88.077 E.09734
; WIPE_START
M204 S6000
G1 X89.807 Y89.491 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X92.185 Y96.743 Z2.16 F42000
G1 X96.279 Y109.223 Z2.16
G1 Z1.76
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X99.849 Y105.653 E.09732
G1 X98.959 Y105.985
G1 X95.721 Y109.223 E.08826
G1 X95.164 Y109.223
G1 X98.36 Y106.027 E.08713
G1 X97.803 Y106.027
G1 X94.606 Y109.223 E.08713
G1 X94.049 Y109.223
G1 X97.245 Y106.027 E.08713
G1 X96.688 Y106.027
G1 X93.491 Y109.223 E.08713
G1 X92.934 Y109.223
G1 X96.13 Y106.027 E.08713
G1 X95.573 Y106.027
G1 X92.376 Y109.223 E.08713
G1 X91.819 Y109.223
G1 X95.015 Y106.027 E.08713
G1 X94.457 Y106.027
G1 X91.261 Y109.223 E.08713
G1 X90.704 Y109.223
G1 X93.9 Y106.027 E.08713
G1 X93.342 Y106.027
G1 X90.146 Y109.223 E.08713
G1 X89.588 Y109.223
G1 X92.785 Y106.027 E.08713
G1 X92.227 Y106.027
G1 X89.031 Y109.223 E.08713
G1 X88.473 Y109.223
G1 X91.67 Y106.027 E.08713
G1 X91.112 Y106.027
G1 X87.916 Y109.223 E.08713
G1 X87.358 Y109.223
G1 X90.555 Y106.027 E.08713
G1 X89.997 Y106.027
G1 X86.801 Y109.223 E.08713
G1 X86.243 Y109.223
G1 X89.44 Y106.027 E.08713
G1 X88.886 Y106.023
G1 X85.686 Y109.223 E.08723
G1 X85.128 Y109.223
G1 X88.396 Y105.955 E.08908
G1 X87.975 Y105.818
G1 X84.571 Y109.223 E.09281
G1 X84.013 Y109.223
G1 X87.609 Y105.627 E.09803
G1 X87.287 Y105.391
G1 X83.48 Y109.199 E.10379
G1 X83.059 Y109.063
G1 X87.009 Y105.112 E.10768
G1 X86.773 Y104.791
G1 X82.723 Y108.841 E.11041
G1 X82.459 Y108.547
G1 X86.582 Y104.424 E.11239
G1 X86.445 Y104.004
G1 X82.269 Y108.179 E.11382
G1 X82.179 Y107.712
G1 X86.377 Y103.514 E.11443
G1 X86.373 Y102.96
G1 X82.177 Y107.157 E.11439
G1 X82.177 Y106.599
G1 X86.373 Y102.403 E.11439
G1 X86.373 Y101.845
G1 X82.177 Y106.042 E.11439
G1 X82.177 Y105.484
G1 X86.373 Y101.288 E.11439
G1 X86.373 Y100.73
G1 X82.177 Y104.926 E.11439
G1 X82.177 Y104.369
G1 X86.373 Y100.173 E.11439
G1 X86.373 Y99.615
G1 X82.177 Y103.811 E.11439
G1 X82.177 Y103.254
G1 X86.373 Y99.058 E.11439
M73 P32 R8
G1 X86.373 Y98.5
G1 X82.177 Y102.696 E.11439
G1 X82.177 Y102.139
G1 X86.373 Y97.942 E.11439
G1 X86.373 Y97.385
G1 X82.177 Y101.581 E.11439
G1 X82.177 Y101.024
G1 X86.373 Y96.827 E.11439
G1 X86.373 Y96.27
G1 X82.177 Y100.466 E.11439
G1 X82.177 Y99.909
G1 X86.373 Y95.712 E.11439
G1 X86.373 Y95.155
G1 X82.177 Y99.351 E.11439
G1 X82.177 Y98.794
G1 X86.373 Y94.597 E.11439
G1 X86.373 Y94.04
G1 X82.177 Y98.236 E.11439
G1 X82.177 Y97.678
G1 X86.415 Y93.441 E.11552
G1 X86.748 Y92.549
G1 X82.177 Y97.121 E.12462
G1 X82.177 Y96.563
G1 X90.663 Y88.077 E.23134
G1 X90.106 Y88.077
G1 X82.177 Y96.006 E.21615
G1 X82.177 Y95.448
G1 X89.548 Y88.077 E.20095
G1 X88.991 Y88.077
G1 X82.177 Y94.891 E.18575
G1 X82.177 Y94.333
G1 X88.433 Y88.077 E.17055
G1 X87.876 Y88.077
G1 X82.177 Y93.776 E.15535
G1 X82.177 Y93.218
G1 X87.318 Y88.077 E.14015
G1 X86.761 Y88.077
G1 X82.177 Y92.661 E.12495
G1 X82.177 Y92.103
G1 X86.203 Y88.077 E.10976
G1 X85.646 Y88.077
G1 X82.177 Y91.546 E.09456
G1 X82.177 Y90.988
G1 X85.088 Y88.077 E.07936
G1 X84.53 Y88.077
G1 X82.177 Y90.43 E.06416
G1 X82.177 Y89.873
G1 X83.973 Y88.077 E.04896
G1 X83.367 Y88.125
G1 X82.225 Y89.267 E.03114
; WIPE_START
M204 S6000
G1 X83.367 Y88.125 E-.61386
G1 X83.751 Y88.094 E-.14614
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.375 Y88.445 Z2.16 F42000
G1 X105.216 Y89.08 Z2.16
G1 Z1.76
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0902108
G1 F21000
M204 S6000
G1 X105.197 Y89.05 E.00011
G3 X105.162 Y88.914 I.05 J-.086 E.00049
M204 S10000
G1 X104.606 Y88.351 F42000
; LINE_WIDTH: 0.0809434
G1 F21000
M204 S6000
G2 X104.503 Y88.27 I-1.293 J1.554 E.00035
; WIPE_START
G1 X104.606 Y88.351 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.932 Y93.456 Z2.16 F42000
G1 X82.338 Y108.386 Z2.16
G1 Z1.76
G1 E.8 F1800
; LINE_WIDTH: 0.0901949
G1 F21000
M204 S6000
G2 X82.303 Y108.249 I-.086 J-.05 E.00049
G1 X82.284 Y108.22 E.00011
; WIPE_START
G1 X82.303 Y108.249 E-.14364
G1 X82.35 Y108.318 E-.33959
G1 X82.338 Y108.386 E-.27677
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.997 Y109.029 Z2.16 F42000
G1 Z1.76
G1 E.8 F1800
; LINE_WIDTH: 0.0815025
G1 F21000
M204 S6000
G3 X82.894 Y108.949 I1.157 J-1.593 E.00036
; WIPE_START
G1 X82.997 Y109.029 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X90.424 Y107.272 Z2.16 F42000
G1 X100.816 Y104.813 Z2.16
G1 Z1.76
G1 E.8 F1800
; LINE_WIDTH: 0.195083
G1 F21000
M204 S6000
G1 X100.512 Y105.168 E.00387
; LINE_WIDTH: 0.169261
G1 X100.134 Y105.534 E.00369
; LINE_WIDTH: 0.206553
G1 X99.913 Y105.716 E.00254
; WIPE_START
G1 X100.134 Y105.534 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X100.773 Y97.928 Z2.16 F42000
G1 X101.146 Y93.484 Z2.16
G1 Z1.76
G1 E.8 F1800
; LINE_WIDTH: 0.0930648
G1 F21000
M204 S6000
G2 X101.059 Y93.324 I-4.459 J2.309 E.0006
; WIPE_START
G1 X101.146 Y93.484 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.076 Y91.341 Z2.16 F42000
G1 Z1.76
G1 E.8 F1800
; LINE_WIDTH: 0.093031
G1 F21000
M204 S6000
G2 X98.916 Y91.254 I-2.702 J4.791 E.0006
; WIPE_START
G1 X99.076 Y91.341 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.445 Y91.502 Z2.16 F42000
G1 X87.587 Y91.584 Z2.16
G1 Z1.76
G1 E.8 F1800
; LINE_WIDTH: 0.195264
G1 F21000
M204 S6000
G1 X87.236 Y91.885 E.00383
; LINE_WIDTH: 0.169353
G1 X86.866 Y92.266 E.00373
; LINE_WIDTH: 0.206518
G1 X86.685 Y92.486 E.00252
; WIPE_START
G1 X86.866 Y92.266 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X87.81 Y99.84 Z2.16 F42000
G1 X88.584 Y106.046 Z2.16
G1 Z1.76
G1 E.8 F1800
; LINE_WIDTH: 0.0930717
G1 F21000
M204 S6000
G3 X88.424 Y105.959 I2.54 J-4.874 E.0006
; OBJECT_ID: 66
; WIPE_START
G1 X88.584 Y106.046 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X89.476 Y98.466 Z2.16 F42000
G1 X91.107 Y84.607 Z2.16
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F21000
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.16 F42000
G1 X103.14 Y85.44 Z2.16
G1 Z1.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.16 F42000
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F21000
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
M73 P33 R8
G1 X95.986 Y83.006 Z2.16 F42000
G1 X85.443 Y83.526 Z2.16
G1 Z1.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X76.557 Y83.526 E.18432
G3 X75.474 Y82.443 I-.01 J-1.073 E.03539
G1 X75.474 Y73.557 E.18432
G3 X76.557 Y72.474 I1.073 J-.01 E.03539
G1 X85.459 Y72.474 E.18465
G3 X86.526 Y73.557 I-.005 J1.072 E.03505
G1 X86.526 Y82.443 E.18432
G3 X85.503 Y83.525 I-1.073 J.01 E.03414
M204 S10000
G1 X85.45 Y83.951 F42000
G1 F21000
M204 S6000
G1 X76.55 Y83.951 E.1846
G3 X75.05 Y82.45 I-.002 J-1.499 E.04891
G1 X75.05 Y73.55 E.1846
G3 X76.55 Y72.05 I1.499 J-.002 E.04891
G1 X85.466 Y72.05 E.18494
G3 X86.951 Y73.55 I-.014 J1.498 E.04857
G1 X86.951 Y82.45 E.1846
G3 X85.51 Y83.949 I-1.499 J.002 E.04767
M204 S250
G1 X85.456 Y84.36 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.544 Y84.36 E.1718
G3 X74.64 Y82.456 I.007 J-1.91 E.05757
G1 X74.64 Y73.544 E.1718
G3 X76.544 Y71.64 I1.91 J.007 E.05757
G1 X85.473 Y71.641 E.17212
G3 X87.36 Y73.544 I-.022 J1.909 E.05725
G1 X87.36 Y82.456 E.1718
G3 X85.516 Y84.359 I-1.91 J-.007 E.05642
; WIPE_START
M204 S6000
G1 X83.516 Y84.359 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.163 Y81.4 Z2.16 F42000
G1 Z1.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F24749.689
M204 S6000
G3 X86.124 Y82.685 I-3.585 J.534 E.0268
G3 X85.886 Y83.009 I-.659 J-.234 E.00846
G2 X83.082 Y83.163 I-1.313 J1.695 E.06353
G1 X78.812 Y83.163 E.08856
G2 X76.049 Y82.952 I-1.513 J1.609 E.06213
G3 X75.837 Y82.426 I.641 J-.565 E.012
G1 X75.837 Y79.598 E.05867
G3 X79.179 Y79.76 I1.601 J1.528 E.07871
G2 X82.821 Y79.882 I1.868 J-1.362 E.08704
G3 X86.162 Y79.486 I1.854 J1.351 E.07835
G1 X86.161 Y75.954 E.07326
G2 X82.821 Y76.118 I-1.599 J1.528 E.07866
G3 X79.179 Y76.24 I-1.868 J-1.362 E.08704
G2 X75.837 Y75.845 I-1.854 J1.351 E.07838
G3 X75.844 Y73.454 I19.281 J-1.139 E.04963
G3 X76.5 Y72.839 I.708 J.099 E.02017
G1 X79.56 Y72.839 E.06347
G2 X82.559 Y72.838 I1.499 J-1.54 E.06884
G1 X84.256 Y72.837 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X82.559 Y72.838 E-.64486
G1 X82.31 Y73.01 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 15/73
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.16 I-1.188 J.266 P1  F42000
G1 X86.54 Y91.89 Z2.16
G1 Z1.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.28 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 15 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer15 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z1.88
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5440
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z2.28 F42000
G1 X85.29 Y104.84 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5440
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z2.28 F42000
G1 X86.54 Y106.19 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5440
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z2.28 F42000
G1 X102.54 Y106.19 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5440
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z2.28 F42000
G1 Z1.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5440
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5440
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z2.28 F42000
G1 X91.107 Y84.607 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5440
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5440
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.28 F42000
G1 X103.14 Y85.44 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.28 F42000
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5440
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5440
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
M73 P34 R8
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.986 Y83 Z2.28 F42000
G1 X85.436 Y83.513 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5440
M204 S6000
G1 X76.564 Y83.513 E.18403
G3 X75.487 Y82.436 I-.009 J-1.067 E.03516
G1 X75.487 Y73.564 E.18403
G3 X76.564 Y72.487 I1.067 J-.01 E.03517
G1 X85.455 Y72.488 E.18442
G3 X86.513 Y73.564 I-.007 J1.066 E.03478
G1 X86.513 Y82.436 E.18403
G3 X85.496 Y83.512 I-1.067 J.009 E.03392
M204 S10000
G1 X85.443 Y83.937 F42000
G1 F5440
M204 S6000
G1 X76.557 Y83.937 E.18432
G3 X75.063 Y82.443 I-.001 J-1.493 E.04868
G1 X75.063 Y73.557 E.18432
G3 X76.557 Y72.063 I1.492 J-.002 E.04869
G1 X85.462 Y72.064 E.1847
G3 X86.937 Y73.557 I-.016 J1.491 E.0483
G1 X86.937 Y82.443 E.18432
G3 X85.503 Y83.936 I-1.493 J.001 E.04744
M204 S250
G1 X85.45 Y84.346 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5440
M204 S5000
G1 X76.55 Y84.346 E.17154
G3 X74.654 Y82.45 I.008 J-1.904 E.05736
G1 X74.654 Y73.55 E.17154
G3 X76.55 Y71.654 I1.903 J.007 E.05737
G1 X85.468 Y71.654 E.1719
G3 X87.346 Y73.55 I-.025 J1.902 E.05701
G1 X87.346 Y82.45 E.17154
G3 X85.51 Y84.345 I-1.904 J-.008 E.05621
; WIPE_START
G1 F12000
M204 S6000
G1 X83.51 Y84.345 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.389 Y81.597 Z2.28 F42000
G1 X75.85 Y81.389 Z2.28
G1 Z1.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5440
M204 S6000
G1 X75.85 Y82.419 E.02137
G2 X76.125 Y83.001 I.756 J-.001 E.01377
G3 X78.902 Y83.15 I1.301 J1.701 E.0628
G1 X83.203 Y83.15 E.08921
G3 X85.938 Y82.946 I1.496 J1.616 E.06141
G2 X86.15 Y82.425 I-.515 J-.513 E.01197
G1 X86.149 Y79.582 E.05896
G2 X82.821 Y79.762 I-1.586 J1.534 E.07835
G3 X79.179 Y79.88 I-1.867 J-1.366 E.08702
G2 X75.85 Y79.476 I-1.853 J1.352 E.07801
G1 X75.85 Y75.942 E.07331
G3 X79.179 Y76.12 I1.587 J1.534 E.07838
G2 X82.821 Y76.239 I1.867 J-1.366 E.08702
G3 X86.148 Y75.832 I1.853 J1.352 E.07795
G1 X86.147 Y73.506 E.04826
G2 X85.437 Y72.851 I-.733 J.082 E.02185
G1 X82.428 Y72.851 E.06241
G3 X79.458 Y72.852 I-1.485 J-1.55 E.06802
G1 X77.761 Y72.853 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X79.458 Y72.852 E-.64486
G1 X79.708 Y73.024 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 16/73
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.28 I-1.144 J.414 P1  F42000
G1 X86.54 Y91.89 Z2.28
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 16 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer16 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5433
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z2.4 F42000
G1 X85.29 Y104.84 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5433
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z2.4 F42000
G1 X86.54 Y106.19 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5433
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z2.4 F42000
G1 X102.54 Y106.19 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5433
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5433
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5433
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z2.4 F42000
G1 X91.107 Y84.607 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5433
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5433
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.4 F42000
G1 X103.14 Y85.44 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
M73 P35 R8
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5433
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5433
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.986 Y82.995 Z2.4 F42000
G1 X85.429 Y83.499 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5433
M204 S6000
G1 X76.571 Y83.499 E.18375
G3 X75.501 Y82.429 I-.01 J-1.06 E.03495
G1 X75.501 Y73.571 E.18375
G3 X76.57 Y72.501 I1.06 J-.01 E.03495
G1 X85.45 Y72.501 E.18419
G3 X86.499 Y73.571 I-.01 J1.059 E.03451
G1 X86.499 Y82.429 E.18375
G3 X85.489 Y83.498 I-1.06 J.01 E.03371
M204 S10000
G1 X85.436 Y83.923 F42000
G1 F5433
M204 S6000
G1 X76.564 Y83.923 E.18404
G3 X75.077 Y82.436 I-.002 J-1.486 E.04847
G1 X75.077 Y73.564 E.18404
G3 X76.564 Y72.077 I1.486 J-.002 E.04847
G1 X85.457 Y72.077 E.18447
G3 X86.923 Y73.564 I-.018 J1.484 E.04803
G1 X86.923 Y82.436 E.18404
G3 X85.496 Y83.922 I-1.486 J.002 E.04723
M204 S250
G1 X85.443 Y84.333 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5433
M204 S5000
G1 X76.557 Y84.333 E.17128
G3 X74.667 Y82.443 I.007 J-1.896 E.05716
G1 X74.667 Y73.557 E.17128
G3 X76.557 Y71.667 I1.896 J.007 E.05716
G1 X85.464 Y71.668 E.17168
G3 X87.333 Y73.557 I-.027 J1.895 E.05676
G1 X87.333 Y82.443 E.17128
G3 X85.503 Y84.332 I-1.896 J-.007 E.05601
; WIPE_START
G1 F12000
M204 S6000
G1 X83.503 Y84.332 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.36 Y81.642 Z2.4 F42000
G1 X75.864 Y81.455 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5433
M204 S6000
G1 X75.864 Y82.412 E.01986
G2 X76.199 Y83.034 I.719 J.013 E.01532
G3 X79.016 Y83.136 I1.352 J1.611 E.06407
G1 X83.347 Y83.136 E.08984
G3 X85.987 Y82.867 I1.494 J1.574 E.05921
G2 X86.136 Y82.418 I-.842 J-.53 E.00992
G1 X86.136 Y79.676 E.05686
M73 P35 R7
G2 X82.821 Y79.639 I-1.674 J1.434 E.07782
G3 X80.09 Y80.645 I-2.092 J-1.47 E.06422
G3 X78.724 Y79.549 I2.15 J-4.077 E.03655
G2 X75.864 Y79.351 I-1.541 J1.509 E.06505
G1 X75.864 Y76.036 E.06876
G3 X79.179 Y75.998 I1.674 J1.433 E.07785
G2 X81.91 Y77.003 I2.092 J-1.47 E.06422
G2 X83.276 Y75.907 I-2.15 J-4.077 E.03655
G3 X86.134 Y75.707 I1.542 J1.509 E.065
G1 X86.134 Y73.515 E.04548
G2 X85.432 Y72.864 I-.721 J.074 E.02167
G1 X82.293 Y72.865 E.06512
G3 X79.345 Y72.866 I-1.474 J-1.537 E.06753
G1 X77.648 Y72.866 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X79.345 Y72.866 E-.64486
G1 X79.572 Y73.067 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 17/73
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.4 I-1.141 J.422 P1  F42000
G1 X86.54 Y91.89 Z2.4
G1 Z2.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.52 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 17 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer17 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z2.12
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5426
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z2.52 F42000
G1 X85.29 Y104.84 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5426
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z2.52 F42000
G1 X86.54 Y106.19 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5426
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z2.52 F42000
G1 X102.54 Y106.19 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5426
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z2.52 F42000
G1 Z2.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5426
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5426
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z2.52 F42000
G1 X91.107 Y84.607 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5426
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5426
M204 S6000
M73 P36 R7
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.52 F42000
G1 X103.14 Y85.44 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.52 F42000
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5426
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5426
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.985 Y82.989 Z2.52 F42000
G1 X85.423 Y83.486 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5426
M204 S6000
G1 X76.577 Y83.486 E.18347
G3 X75.514 Y82.423 I-.01 J-1.053 E.03473
G1 X75.514 Y73.577 E.18347
G3 X76.577 Y72.514 I1.053 J-.01 E.03473
G1 X85.445 Y72.515 E.18394
G3 X86.486 Y73.578 I-.011 J1.052 E.03425
G1 X86.486 Y82.423 E.18347
G3 X85.482 Y83.485 I-1.053 J.01 E.03349
M204 S10000
G1 X85.429 Y83.91 F42000
G1 F5426
M204 S6000
G1 X76.571 Y83.91 E.18376
G3 X75.09 Y82.429 I-.002 J-1.478 E.04825
G1 X75.09 Y73.571 E.18376
G3 X76.571 Y72.09 I1.478 J-.002 E.04825
G1 X85.453 Y72.091 E.18423
G3 X86.91 Y73.571 I-.02 J1.478 E.04777
G1 X86.91 Y82.429 E.18376
G3 X85.489 Y83.909 I-1.478 J.002 E.04701
M204 S250
G1 X85.436 Y84.319 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5426
M204 S5000
G1 X76.564 Y84.319 E.17102
G3 X74.681 Y82.436 I.006 J-1.889 E.05696
G1 X74.681 Y73.564 E.17102
G3 X76.564 Y71.681 I1.889 J.006 E.05696
G1 X85.459 Y71.682 E.17146
G3 X87.319 Y73.564 I-.029 J1.888 E.05651
G1 X87.319 Y82.436 E.17102
G3 X85.496 Y84.318 I-1.889 J-.006 E.05581
; WIPE_START
G1 F12000
M204 S6000
G1 X83.496 Y84.318 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.334 Y81.681 Z2.52 F42000
G1 X75.877 Y81.513 Z2.52
G1 Z2.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5426
M204 S6000
G1 X75.877 Y82.406 E.01852
G2 X76.221 Y83.03 I.712 J.015 E.01547
G2 X76.903 Y82.663 I-.634 J-2 E.01616
G3 X79.145 Y83.123 I.798 J1.805 E.05062
G1 X83.475 Y83.123 E.08981
G3 X86.029 Y82.78 I1.509 J1.551 E.05728
G2 X86.116 Y82.523 I-.91 J-.45 E.00563
G2 X86.122 Y79.771 I-22.086 J-1.425 E.05713
G2 X83.731 Y78.914 I-1.917 J1.584 E.05529
G2 X82.366 Y79.992 I1.429 J3.212 E.03648
G3 X79.634 Y80.523 I-1.709 J-1.506 E.06208
G2 X78.269 Y79.264 I-107.946 J115.746 E.03852
G2 X75.877 Y79.219 I-1.229 J1.7 E.0528
G1 X75.877 Y76.13 E.06406
G3 X78.269 Y75.272 I1.918 J1.583 E.05532
G3 X79.634 Y76.351 I-1.429 J3.213 E.03648
G2 X82.366 Y76.881 I1.709 J-1.505 E.06208
G3 X83.731 Y75.623 I107.803 J115.59 E.03852
G3 X86.121 Y75.575 I1.229 J1.701 E.05274
G1 X86.12 Y73.521 E.0426
G2 X85.428 Y72.878 I-.718 J.079 E.02137
G1 X82.165 Y72.879 E.06767
G3 X81.455 Y73.337 I-1.419 J-1.419 E.01766
G3 X79.216 Y72.879 I-.797 J-1.804 E.05056
G1 X77.519 Y72.88 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X79.216 Y72.879 E-.64486
G1 X79.446 Y73.077 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 18/73
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.52 I-1.139 J.429 P1  F42000
G1 X86.54 Y91.89 Z2.52
G1 Z2.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.64 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 18 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer18 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z2.24
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5422
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z2.64 F42000
G1 X85.29 Y104.84 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5422
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z2.64 F42000
G1 X86.54 Y106.19 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5422
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z2.64 F42000
G1 X102.54 Y106.19 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
M73 P37 R7
G1 F5422
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z2.64 F42000
G1 Z2.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5422
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5422
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z2.64 F42000
G1 X91.107 Y84.607 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5422
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5422
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.64 F42000
G1 X103.14 Y85.44 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.64 F42000
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5422
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5422
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.985 Y82.983 Z2.64 F42000
G1 X85.416 Y83.472 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5422
M204 S6000
G1 X76.584 Y83.472 E.18319
G3 X75.528 Y82.416 I-.009 J-1.047 E.0345
G1 X75.528 Y73.584 E.18319
G3 X76.584 Y72.528 I1.045 J-.011 E.03452
G1 X85.441 Y72.529 E.18371
G3 X86.472 Y73.584 I-.012 J1.044 E.034
G1 X86.472 Y82.416 E.18319
G3 X85.476 Y83.471 I-1.047 J.009 E.03326
M204 S10000
G1 X85.423 Y83.896 F42000
G1 F5422
M204 S6000
G1 X76.577 Y83.896 E.18348
G3 X75.104 Y82.423 I-.001 J-1.473 E.04802
G1 X75.104 Y73.577 E.18348
G3 X76.577 Y72.104 I1.471 J-.003 E.04804
G1 X85.448 Y72.104 E.184
G3 X86.896 Y73.577 I-.021 J1.469 E.04751
G1 X86.896 Y82.423 E.18348
G3 X85.483 Y83.895 I-1.473 J.001 E.04678
M204 S250
G1 X85.429 Y84.306 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5422
M204 S5000
G1 X76.571 Y84.306 E.17076
G3 X74.694 Y82.429 I.008 J-1.884 E.05675
G1 X74.694 Y73.571 E.17076
G3 X76.571 Y71.694 I1.881 J.005 E.05677
G1 X85.455 Y71.695 E.17125
G3 X87.306 Y73.571 I-.029 J1.88 E.05628
G1 X87.306 Y82.429 E.17076
G3 X85.489 Y84.304 I-1.884 J-.008 E.05559
; WIPE_START
G1 F12000
M204 S6000
G1 X83.489 Y84.305 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.325 Y81.672 Z2.64 F42000
G1 X75.891 Y81.512 Z2.64
G1 Z2.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5422
M204 S6000
G1 X75.891 Y82.399 E.0184
G2 X76.295 Y83.046 I.778 J-.036 E.01656
G1 X76.448 Y82.961 E.00363
G3 X78.724 Y82.63 I1.416 J1.745 E.05008
G2 X79.373 Y83.109 I1.323 J-1.113 E.01688
G1 X83.465 Y83.109 E.08489
G2 X84.186 Y82.679 I-4.114 J-7.712 E.01743
G3 X86.06 Y82.675 I.941 J1.744 E.04048
G2 X86.102 Y82.516 I-.38 J-.187 E.00344
G2 X86.109 Y79.901 I-20.923 J-1.356 E.05427
G1 X85.552 Y79.32 E.01669
G2 X83.276 Y78.989 I-1.416 J1.745 E.05008
G2 X81.91 Y80.322 I5.434 J6.933 E.03966
G3 X79.634 Y80.653 I-1.416 J-1.745 E.05008
G3 X78.269 Y79.32 I5.435 J-6.934 E.03966
G1 X77.814 Y79.037 E.01111
G2 X75.891 Y79.075 I-.929 J1.686 E.04177
G1 X75.891 Y76.26 E.05838
G1 X76.448 Y75.678 E.01672
G3 X78.724 Y75.347 I1.416 J1.745 E.05008
G3 X80.09 Y76.68 I-5.434 J6.933 E.03966
G2 X82.366 Y77.011 I1.416 J-1.745 E.05008
G2 X83.731 Y75.678 I-5.435 J-6.934 E.03966
G1 X84.186 Y75.396 E.01111
G3 X86.107 Y75.431 I.929 J1.688 E.04171
G1 X86.107 Y73.523 E.03959
G2 X85.423 Y72.892 I-.712 J.085 E.021
G1 X82.051 Y72.892 E.06995
G3 X81.455 Y73.321 I-1.133 J-.944 E.01539
G3 X79.089 Y72.893 I-.922 J-1.657 E.05403
G1 X77.392 Y72.893 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X79.089 Y72.893 E-.64486
G1 X79.317 Y73.092 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 19/73
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.64 I-1.136 J.437 P1  F42000
G1 X86.54 Y91.89 Z2.64
G1 Z2.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.76 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 19 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer19 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z2.36
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z2.76 F42000
G1 X85.29 Y104.84 Z2.76
G1 Z2.36
M73 P38 R7
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z2.76 F42000
G1 X86.54 Y106.19 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z2.76 F42000
G1 X102.54 Y106.19 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z2.76 F42000
G1 Z2.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z2.76 F42000
G1 X91.107 Y84.607 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5418
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.76 F42000
G1 X103.14 Y85.44 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.76 F42000
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5418
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.985 Y82.977 Z2.76 F42000
G1 X85.409 Y83.459 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X76.591 Y83.459 E.18291
G3 X75.541 Y82.409 I-.01 J-1.039 E.03429
G1 X75.541 Y73.591 E.18291
G3 X76.591 Y72.541 I1.039 J-.01 E.03429
G1 X85.436 Y72.542 E.18348
G3 X86.459 Y73.591 I-.016 J1.038 E.03372
G1 X86.459 Y82.409 E.18291
G3 X85.469 Y83.458 I-1.039 J.01 E.03305
M204 S10000
G1 X85.416 Y83.883 F42000
G1 F5418
M204 S6000
G1 X76.584 Y83.883 E.1832
G3 X75.117 Y82.416 I-.002 J-1.465 E.04781
G1 X75.117 Y73.584 E.1832
G3 X76.584 Y72.117 I1.465 J-.002 E.04781
G1 X85.443 Y72.118 E.18377
G3 X86.883 Y73.584 I-.025 J1.464 E.04724
G1 X86.883 Y82.416 E.1832
G3 X85.476 Y83.882 I-1.465 J.002 E.04657
M204 S250
G1 X85.423 Y84.292 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X76.577 Y84.292 E.1705
G3 X74.708 Y82.423 I.007 J-1.876 E.05655
G1 X74.708 Y73.577 E.1705
G3 X76.577 Y71.708 I1.876 J.007 E.05655
G1 X85.45 Y71.709 E.17103
G3 X87.292 Y73.577 I-.033 J1.875 E.05602
G1 X87.292 Y82.423 E.1705
G3 X85.483 Y84.291 I-1.876 J-.007 E.0554
; WIPE_START
G1 F12000
M204 S6000
G1 X83.483 Y84.291 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.303 Y81.701 Z2.76 F42000
G1 X75.904 Y81.557 Z2.76
G1 Z2.36
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X75.904 Y82.392 E.01733
G2 X76.133 Y82.927 I.927 J-.08 E.01229
G2 X76.448 Y83.013 I.21 J-.15 E.00733
G3 X78.724 Y82.483 I1.605 J1.737 E.0507
G2 X79.539 Y83.096 I3.858 J-4.283 E.02118
G1 X83.566 Y83.096 E.08353
G1 X83.731 Y83.013 E.00383
G3 X86.007 Y82.483 I1.605 J1.737 E.0507
M73 P39 R7
G1 X86.089 Y82.508 E.00177
G2 X86.095 Y80.003 I-20.112 J-1.301 E.05199
G2 X84.186 Y78.736 I-2.356 J1.477 E.04898
G2 X82.821 Y79.211 I-.247 J1.488 E.03128
G1 X81.91 Y80.27 E.02896
G3 X80.545 Y80.906 I-1.881 J-2.255 E.0316
G3 X79.179 Y80.43 I-.247 J-1.488 E.03128
G1 X78.269 Y79.372 E.02896
G2 X75.993 Y78.841 I-1.605 J1.737 E.0507
G1 X75.904 Y78.913 E.00237
G1 X75.904 Y76.363 E.05291
G3 X77.814 Y75.094 I2.357 J1.478 E.04901
G3 X79.179 Y75.57 I.247 J1.489 E.03128
G1 X80.09 Y76.628 E.02896
G2 X81.455 Y77.264 I1.881 J-2.255 E.0316
G2 X82.821 Y76.789 I.247 J-1.488 E.03128
G1 X83.731 Y75.73 E.02896
G3 X86.007 Y75.2 I1.605 J1.737 E.0507
G1 X86.094 Y75.27 E.00231
G1 X86.093 Y73.53 E.03608
G2 X85.418 Y72.905 I-.703 J.082 E.02078
G1 X81.98 Y72.906 E.07131
G3 X80.09 Y73.641 I-1.826 J-1.899 E.04318
G3 X78.972 Y72.906 I.405 J-1.834 E.02836
G1 X77.275 Y72.907 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.972 Y72.906 E-.64486
G1 X79.195 Y73.112 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 20/73
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.76 I-1.133 J.443 P1  F42000
G1 X86.54 Y91.89 Z2.76
G1 Z2.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.88 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 20 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer20 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z2.48
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z2.88 F42000
G1 X85.29 Y104.84 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z2.88 F42000
G1 X86.54 Y106.19 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z2.88 F42000
G1 X102.54 Y106.19 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z2.88 F42000
G1 Z2.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5418
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z2.88 F42000
G1 X91.107 Y84.607 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5418
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z2.88 F42000
G1 X103.14 Y85.44 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z2.88 F42000
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5418
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.984 Y82.971 Z2.88 F42000
G1 X85.402 Y83.445 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X76.598 Y83.445 E.18263
G3 X75.555 Y82.402 I-.01 J-1.033 E.03407
G1 X75.555 Y73.598 E.18263
G3 X76.598 Y72.555 I1.033 J-.01 E.03407
G1 X85.432 Y72.556 E.18324
G3 X86.445 Y73.598 I-.018 J1.031 E.03345
G1 X86.445 Y82.402 E.18263
G3 X85.462 Y83.444 I-1.033 J.01 E.03282
M204 S10000
G1 X85.409 Y83.869 F42000
G1 F5418
M204 S6000
G1 X76.591 Y83.869 E.18292
G3 X75.131 Y82.409 I-.002 J-1.458 E.04759
G1 X75.131 Y73.591 E.18292
G3 X76.591 Y72.131 I1.458 J-.002 E.04759
G1 X85.439 Y72.132 E.18353
M73 P40 R7
G3 X86.869 Y73.591 I-.027 J1.457 E.04697
G1 X86.869 Y82.409 E.18292
G3 X85.469 Y83.868 I-1.458 J.002 E.04635
M204 S250
G1 X85.416 Y84.279 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5418
M204 S5000
G1 X76.584 Y84.279 E.17024
G3 X74.721 Y82.416 I.007 J-1.869 E.05635
G1 X74.721 Y73.584 E.17024
G3 X76.584 Y71.721 I1.869 J.007 E.05635
G1 X85.446 Y71.722 E.17081
G3 X87.279 Y73.584 I-.035 J1.868 E.05577
G1 X87.279 Y82.416 E.17024
G3 X85.476 Y84.277 I-1.869 J-.007 E.05519
; WIPE_START
G1 F12000
M204 S6000
G1 X83.476 Y84.278 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.275 Y81.748 Z2.88 F42000
G1 X75.918 Y81.623 Z2.88
G1 Z2.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5418
M204 S6000
G1 X75.918 Y82.386 E.01582
G2 X76.447 Y83.063 I.67 J.023 E.01937
G3 X78.269 Y82.243 I1.989 J1.986 E.04236
G1 X78.724 Y82.31 E.00954
G3 X79.656 Y83.082 I-4.802 J6.746 E.02512
G1 X83.688 Y83.082 E.08362
G3 X85.552 Y82.243 I2.059 J2.085 E.04332
G1 X86.082 Y82.368 E.0113
G1 X86.082 Y80.121 E.0466
G2 X83.731 Y78.602 I-2.565 J1.391 E.06055
G1 X83.276 Y78.669 E.00954
G1 X82.821 Y79.017 E.01189
G1 X81.91 Y80.22 E.0313
G3 X80.09 Y81.04 I-2.061 J-2.146 E.04224
G1 X79.634 Y80.973 E.00954
G1 X79.179 Y80.625 E.01189
G1 X78.269 Y79.421 E.0313
G2 X76.448 Y78.602 I-2.06 J2.145 E.04224
G1 X75.918 Y78.726 E.0113
G1 X75.918 Y76.481 E.04658
G3 X78.269 Y74.96 I2.567 J1.391 E.06057
G1 X78.724 Y75.027 E.00954
G1 X79.179 Y75.376 E.01189
G1 X80.09 Y76.579 E.0313
G2 X81.91 Y77.398 I2.06 J-2.145 E.04224
G1 X82.366 Y77.331 E.00954
G1 X82.821 Y76.983 E.01189
G1 X83.731 Y75.78 E.0313
G3 X85.552 Y74.96 I2.061 J2.146 E.04224
G1 X86.08 Y75.083 E.01124
G1 X86.08 Y73.543 E.03193
G2 X85.414 Y72.919 I-.697 J.076 E.02062
G1 X81.924 Y72.919 E.07239
G3 X80.09 Y73.757 I-1.997 J-1.946 E.04279
G1 X79.634 Y73.69 E.00954
G3 X78.86 Y72.92 I1.005 J-1.784 E.02292
G1 X77.163 Y72.92 E.0352
M106 S255
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.86 Y72.92 E-.64486
G1 X79.043 Y73.162 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M106 S201.45
M625
; layer num/total_layer_count: 21/73
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
M204 S10000
G17
G3 Z2.88 I-.759 J.952 P1  F42000
G1 X102.54 Y91.89 Z2.88
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
; WIPE_START
M204 S6000
G1 X100.96 Y91.89 E-.60084
G1 X100.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M106 S201.45
M625
; object ids of layer 21 start: 66,77,88
M624 BwAAAAAAAAA=
M106 S255
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer21 end: 66,77,88
M106 S201.45
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
G1 X101.165 Y91.5
G1 Z2.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X102.335 Y91.5 E.02122
; WIPE_START
G1 X101.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.996 Y99.087 Z3 F42000
G1 X102.581 Y104.431 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3200.811
M204 S6000
G1 X102.183 Y104.431 E.00826
G1 F840
G1 X101.819 Y104.431 E.00753
G1 F600
G1 X101.819 Y92.869 E.23982
M106 S201.45
M106 S255
G1 F840
G1 X102.183 Y92.869 E.00753
G1 F3200.811
G1 X102.581 Y92.869 E.00826
G1 F7104.555
G1 X102.581 Y93.269 E.0083
G1 F12544.299
G1 X102.581 Y93.669 E.0083
G1 F19520.043
G1 X102.581 Y94.069 E.0083
G1 F21000
G1 X102.581 Y94.469 E.0083
G1 X102.581 Y104.371 E.20538
M204 S250
G1 X102.99 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6622.076
M204 S5000
G1 X102.569 Y104.84 E.00812
G1 F2725.645
G1 X102.169 Y104.84 E.00771
G1 F600
G1 X101.8 Y104.84 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X101.41 Y104.84 E.00809
G1 X101.41 Y92.46 E.25679
G1 X101.8 Y92.46 E.00809
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X102.169 Y92.46 E.00711
M106 S201.45
M106 S255
G1 F2725.645
G1 X102.569 Y92.46 E.00771
G1 F6622.076
G1 X102.99 Y92.46 E.00812
G1 F11900.399
G1 X102.99 Y92.86 E.00771
G1 F12000
G1 X102.99 Y93.26 E.00771
G1 X102.99 Y104.78 E.22206
M204 S10000
G1 X102.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F21000
M204 S6000
G1 X102.2 Y93.081 E.18366
; WIPE_START
G1 X102.2 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.434 Y102.71 Z3 F42000
G1 X102.54 Y106.19 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.705 Y105.988 Z3 F42000
G1 X86.54 Y106.19 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.354 Y104.431 Z3 F42000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F840
M204 S6000
G1 X85.318 Y104.431 E.00075
G1 F3200.811
G1 X84.919 Y104.431 E.00826
G1 F7104.555
G1 X84.919 Y104.031 E.0083
G1 F12544.299
G1 X84.919 Y103.631 E.0083
G1 F19520.043
G1 X84.919 Y103.231 E.0083
G1 F21000
G1 X84.919 Y102.831 E.0083
G1 X84.919 Y94.469 E.17344
G1 X84.919 Y94.069 E.0083
G1 F19520.043
G1 X84.919 Y93.669 E.0083
G1 F12544.299
G1 X84.919 Y93.269 E.0083
G1 F7104.555
G1 X84.919 Y92.869 E.0083
G1 F3200.811
G1 X85.318 Y92.869 E.00826
G1 F840
G1 X85.681 Y92.869 E.00753
G1 F600
G1 X85.681 Y104.431 E.23982
M106 S201.45
M106 S255
G1 F840
G1 X85.414 Y104.431 E.00554
M204 S250
M73 P41 R7
G1 X85.354 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
M204 S5000
G1 X85.331 Y104.84 E.00044
M106 S201.45
M106 S255
G1 F2725.645
G1 X84.931 Y104.84 E.00771
G1 F6622.076
G1 X84.51 Y104.84 E.00812
G1 F11900.399
G1 X84.51 Y104.44 E.00771
G1 F12000
G1 X84.51 Y104.04 E.00771
G1 X84.51 Y93.26 E.20779
G1 X84.51 Y92.86 E.00771
G1 F11900.399
G1 X84.51 Y92.46 E.00771
G1 F6622.076
G1 X84.931 Y92.46 E.00812
G1 F2725.645
G1 X85.331 Y92.46 E.00771
G1 F600
G1 X85.7 Y92.46 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X86.09 Y92.46 E.00809
G1 X86.09 Y104.84 E.25679
M106 S201.45
M106 S255
G1 F1800
G1 X85.7 Y104.84 E.00809
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X85.414 Y104.84 E.00552
M106 S201.45
M204 S10000
G1 X85.3 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F21000
M204 S6000
G1 X85.3 Y93.081 E.18366
; WIPE_START
G1 X85.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3 I1.134 J.441 P1  F42000
G1 X86.54 Y91.89 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
M204 S10000
G1 X86.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X85.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 X86.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X90.679 Y85.224 Z3 F42000
G1 X91.107 Y84.607 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F21000
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3 F42000
G1 X103.14 Y85.44 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3 F42000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F21000
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.984 Y82.966 Z3 F42000
G1 X85.396 Y83.432 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X76.604 Y83.432 E.18235
G3 X75.568 Y82.396 I-.009 J-1.027 E.03384
G1 X75.568 Y73.604 E.18235
G3 X76.604 Y72.568 I1.027 J-.009 E.03384
G1 X85.427 Y72.569 E.18301
G3 X86.432 Y73.604 I-.02 J1.024 E.03319
G1 X86.432 Y82.396 E.18235
G3 X85.456 Y83.43 I-1.027 J.009 E.0326
M204 S10000
G1 X85.402 Y83.856 F42000
G1 F21000
M204 S6000
G1 X76.598 Y83.856 E.18264
G3 X75.144 Y82.402 I-.001 J-1.452 E.04736
G1 X75.144 Y73.598 E.18264
G3 X76.597 Y72.144 I1.452 J-.001 E.04736
G1 X85.434 Y72.145 E.1833
G3 X86.856 Y73.598 I-.029 J1.45 E.04671
G1 X86.856 Y82.402 E.18264
G3 X85.462 Y83.855 I-1.452 J.001 E.04612
M204 S250
G1 X85.409 Y84.265 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.591 Y84.265 E.16998
G3 X74.735 Y82.409 I.007 J-1.863 E.05613
G1 X74.735 Y73.591 E.16998
G3 X76.591 Y71.735 I1.863 J.007 E.05613
G1 X85.441 Y71.736 E.17059
G3 X87.265 Y73.591 I-.037 J1.861 E.05552
G1 X87.265 Y82.409 E.16998
G3 X85.469 Y84.264 I-1.863 J-.007 E.05498
; WIPE_START
M204 S6000
G1 X83.469 Y84.264 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.257 Y81.767 Z3 F42000
G1 X75.931 Y81.654 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F24749.689
M204 S6000
G1 X75.931 Y82.379 E.01503
G2 X76.501 Y83.061 I.68 J.011 E.02008
G3 X78.269 Y82.111 I2.337 J2.231 E.04232
G1 X78.724 Y82.099 E.00945
G1 X79.179 Y82.395 E.01127
G1 X79.584 Y83.069 E.01629
G1 X83.775 Y83.069 E.08695
G3 X85.552 Y82.111 I2.349 J2.231 E.04257
G1 X86.069 Y82.139 E.01073
G1 X86.068 Y80.231 E.03957
G2 X83.731 Y78.47 I-2.943 J1.474 E.0629
G1 X83.276 Y78.457 E.00945
G1 X82.821 Y78.754 E.01127
G1 X82.366 Y79.512 E.01834
G3 X80.09 Y81.172 I-2.792 J-1.437 E.0606
G1 X79.634 Y81.184 E.00945
G1 X79.179 Y80.888 E.01127
G1 X78.724 Y80.13 E.01834
G2 X76.448 Y78.47 I-2.792 J1.437 E.0606
G1 X75.931 Y78.497 E.01074
G1 X75.931 Y76.591 E.03954
G3 X78.269 Y74.828 I2.945 J1.473 E.06293
G1 X78.724 Y74.816 E.00945
G1 X79.179 Y75.112 E.01127
G1 X79.634 Y75.87 E.01834
G2 X81.91 Y77.53 I2.792 J-1.437 E.0606
G1 X82.366 Y77.543 E.00945
G1 X82.821 Y77.246 E.01127
G1 X83.276 Y76.488 E.01834
G3 X85.552 Y74.828 I2.792 J1.437 E.0606
G1 X86.066 Y74.854 E.01068
G1 X86.066 Y73.544 E.02717
G2 X85.408 Y72.932 I-.691 J.082 E.02026
G1 X81.865 Y72.933 E.07351
G3 X80.09 Y73.889 I-2.347 J-2.231 E.04252
G1 X79.634 Y73.901 E.00945
G1 X79.179 Y73.605 E.01127
G1 X78.776 Y72.933 E.01624
G1 X77.079 Y72.934 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.776 Y72.933 E-.64486
G1 X78.932 Y73.193 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 22/73
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3 I-.756 J.954 P1  F42000
G1 X102.54 Y91.89 Z3
G1 Z2.72
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X100.96 Y91.89 E-.60084
G1 X100.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.12 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 22 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer22 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X101.165 Y91.5
G1 Z2.72
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6072
M204 S6000
G1 X102.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X101.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.996 Y99.087 Z3.12 F42000
G1 X102.581 Y104.431 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6072
M204 S6000
G1 X101.819 Y104.431 E.0158
M73 P42 R7
G1 X101.819 Y92.869 E.23982
G1 X102.581 Y92.869 E.0158
G1 X102.581 Y104.371 E.23857
M204 S250
G1 X102.99 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X101.41 Y104.84 E.03046
G1 X101.41 Y92.46 E.23863
G1 X102.99 Y92.46 E.03046
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F6072
M204 S6000
G1 X102.2 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X102.2 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.434 Y102.71 Z3.12 F42000
G1 X102.54 Y106.19 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6072
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.705 Y105.988 Z3.12 F42000
G1 X86.54 Y106.19 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6072
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.351 Y104.431 Z3.12 F42000
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6072
M204 S6000
G1 X84.919 Y104.431 E.00897
G1 X84.919 Y92.869 E.23982
G1 X85.681 Y92.869 E.0158
G1 X85.681 Y104.431 E.23982
G1 X85.411 Y104.431 E.00559
M204 S250
G1 X85.351 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X84.51 Y104.84 E.01622
G1 X84.51 Y92.46 E.23863
G1 X86.09 Y92.46 E.03046
G1 X86.09 Y104.84 E.23863
G1 X85.411 Y104.84 E.01308
M204 S10000
G1 X85.3 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F6072
M204 S6000
G1 X85.3 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X85.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.12 I1.134 J.441 P1  F42000
G1 X86.54 Y91.89 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
M204 S10000
G1 X86.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6072
M204 S6000
G1 X85.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X86.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X90.679 Y85.224 Z3.12 F42000
G1 X91.107 Y84.607 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6072
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F6072
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3.12 F42000
G1 X103.14 Y85.44 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.12 F42000
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6072
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F6072
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.984 Y82.96 Z3.12 F42000
G1 X85.389 Y83.418 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6072
M204 S6000
G1 X76.611 Y83.418 E.18206
G3 X75.582 Y82.389 I-.01 J-1.019 E.03364
G1 X75.582 Y73.611 E.18206
G3 X76.611 Y72.582 I1.017 J-.012 E.03364
G1 X85.423 Y72.583 E.18278
G3 X86.418 Y73.611 I-.02 J1.016 E.03294
G1 X86.418 Y82.389 E.18206
G3 X85.449 Y83.417 I-1.02 J.01 E.03239
M204 S10000
G1 X85.396 Y83.842 F42000
G1 F6072
M204 S6000
G1 X76.604 Y83.842 E.18236
G3 X75.158 Y82.396 I-.002 J-1.445 E.04715
G1 X75.158 Y73.604 E.18236
G3 X76.604 Y72.158 I1.443 J-.004 E.04717
G1 X85.43 Y72.159 E.18306
G3 X86.842 Y73.604 I-.029 J1.441 E.04645
G1 X86.842 Y82.396 E.18236
G3 X85.456 Y83.841 I-1.446 J.001 E.0459
M204 S250
G1 X85.402 Y84.252 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6072
M204 S5000
G1 X76.598 Y84.252 E.16972
G3 X74.748 Y82.402 I.006 J-1.856 E.05594
G1 X74.748 Y73.598 E.16972
G3 X76.598 Y71.748 I1.854 J.005 E.05595
G1 X85.436 Y71.75 E.17037
G3 X87.252 Y73.598 I-.037 J1.852 E.05529
G1 X87.252 Y82.402 E.16972
G3 X85.462 Y84.25 I-1.857 J-.007 E.05478
; WIPE_START
G1 F12000
M204 S6000
G1 X83.462 Y84.251 E-.76
; WIPE_END
M73 P43 R7
G1 E-.04 F1800
M204 S10000
G1 X76.242 Y81.777 Z3.12 F42000
G1 X75.945 Y81.676 Z3.12
G1 Z2.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6072
M204 S6000
G1 X75.945 Y82.372 E.01444
G2 X76.515 Y83.049 I.663 J.021 E.02011
G3 X78.269 Y81.96 I2.838 J2.616 E.04334
G3 X79.179 Y81.869 I.562 J1.011 E.01951
G1 X79.72 Y83.055 E.02705
G1 X83.825 Y83.055 E.08516
G1 X84.186 Y82.673 E.01091
G3 X86.007 Y81.82 I3.648 J5.416 E.04187
G1 X86.055 Y81.825 E.001
G1 X86.055 Y80.437 E.02879
G2 X83.731 Y78.319 I-3.239 J1.22 E.06769
G2 X82.821 Y78.227 I-.562 J1.011 E.01951
G1 X82.366 Y79.319 E.02454
G3 X80.09 Y81.323 I-3.204 J-1.344 E.06509
G3 X79.179 Y81.415 I-.562 J-1.011 E.01951
G1 X78.724 Y80.323 E.02454
G2 X77.814 Y79.031 I-3.045 J1.18 E.03311
G2 X75.993 Y78.178 I-3.647 J5.415 E.04187
G1 X75.945 Y78.183 E.001
G1 X75.945 Y76.797 E.02876
G3 X78.269 Y74.677 I3.24 J1.219 E.06773
G3 X79.179 Y74.585 I.562 J1.011 E.01951
G1 X79.634 Y75.677 E.02454
G2 X81.91 Y77.681 I3.204 J-1.344 E.06509
G2 X82.821 Y77.773 I.562 J-1.011 E.01951
G1 X83.276 Y76.681 E.02454
G3 X84.186 Y75.39 I3.045 J1.18 E.03311
G3 X86.007 Y74.536 I3.648 J5.416 E.04187
G1 X86.053 Y74.541 E.00095
G1 X86.053 Y73.558 E.0204
G2 X85.404 Y72.946 I-.681 J.072 E.02014
G1 X81.815 Y72.947 E.07445
G3 X80.09 Y74.04 I-2.72 J-2.384 E.04295
G3 X79.179 Y74.132 I-.562 J-1.011 E.01951
G2 X78.672 Y72.947 I-5.283 J1.562 E.02679
G1 X76.975 Y72.947 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.672 Y72.947 E-.64486
G1 X78.791 Y73.226 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 23/73
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.12 I-.752 J.957 P1  F42000
G1 X102.54 Y91.89 Z3.12
G1 Z2.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X100.96 Y91.89 E-.60084
G1 X100.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.24 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 23 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer23 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X101.165 Y91.5
G1 Z2.84
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6010
M204 S6000
G1 X102.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X101.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.996 Y99.087 Z3.24 F42000
G1 X102.581 Y104.431 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6010
M204 S6000
G1 X101.819 Y104.431 E.0158
G1 X101.819 Y92.869 E.23982
G1 X102.581 Y92.869 E.0158
G1 X102.581 Y104.371 E.23857
M204 S250
G1 X102.99 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X101.41 Y104.84 E.03046
G1 X101.41 Y92.46 E.23863
G1 X102.99 Y92.46 E.03046
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F6010
M204 S6000
G1 X102.2 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X102.2 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.434 Y102.71 Z3.24 F42000
G1 X102.54 Y106.19 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6010
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.705 Y105.988 Z3.24 F42000
G1 X86.54 Y106.19 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6010
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.349 Y104.431 Z3.24 F42000
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6010
M204 S6000
G1 X84.919 Y104.431 E.00892
G1 X84.919 Y92.869 E.23982
G1 X85.681 Y92.869 E.0158
G1 X85.681 Y104.431 E.23982
G1 X85.409 Y104.431 E.00564
M204 S250
G1 X85.349 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X84.51 Y104.84 E.01617
G1 X84.51 Y92.46 E.23863
G1 X86.09 Y92.46 E.03046
G1 X86.09 Y104.84 E.23863
G1 X85.409 Y104.84 E.01313
M204 S10000
G1 X85.3 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F6010
M204 S6000
G1 X85.3 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X85.3 Y95.081 E-.76
; WIPE_END
M73 P43 R6
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.24 I1.134 J.441 P1  F42000
G1 X86.54 Y91.89 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
M204 S10000
G1 X86.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6010
M204 S6000
G1 X85.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X86.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X90.679 Y85.224 Z3.24 F42000
G1 X91.107 Y84.607 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6010
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F6010
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3.24 F42000
G1 X103.14 Y85.44 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.24 F42000
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6010
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F6010
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
M73 P44 R6
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.984 Y82.954 Z3.24 F42000
G1 X85.382 Y83.405 Z3.24
G1 Z2.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6010
M204 S6000
G1 X76.618 Y83.405 E.18179
G3 X75.595 Y82.382 I-.01 J-1.012 E.03341
G1 X75.595 Y73.618 E.18179
G3 X76.618 Y72.595 I1.012 J-.01 E.0334
G1 X85.418 Y72.597 E.18254
G3 X86.405 Y73.618 I-.024 J1.01 E.03266
G1 X86.405 Y82.382 E.18179
G3 X85.442 Y83.403 I-1.012 J.01 E.03216
M204 S10000
G1 X85.389 Y83.829 F42000
G1 F6010
M204 S6000
G1 X76.611 Y83.829 E.18207
G3 X75.171 Y82.389 I-.002 J-1.438 E.04693
G1 X75.171 Y73.611 E.18207
G3 X76.611 Y72.171 I1.438 J-.002 E.04693
G1 X85.425 Y72.172 E.18283
G3 X86.829 Y73.611 I-.033 J1.436 E.04617
G1 X86.829 Y82.389 E.18207
G3 X85.449 Y83.828 I-1.438 J.002 E.04569
M204 S250
G1 X85.396 Y84.238 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6010
M204 S5000
G1 X76.604 Y84.238 E.16946
G3 X74.762 Y82.396 I.006 J-1.849 E.05573
G1 X74.762 Y73.604 E.16946
G3 X76.604 Y71.762 I1.849 J.006 E.05573
G1 X85.432 Y71.763 E.17016
G3 X87.238 Y73.604 I-.041 J1.847 E.05503
G1 X87.238 Y82.396 E.16946
G3 X85.455 Y84.237 I-1.849 J-.006 E.05458
; WIPE_START
G1 F12000
M204 S6000
G1 X83.455 Y84.237 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.145 Y83.042 Z3.24 F42000
G1 Z2.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6010
M204 S6000
G1 X83.863 Y83.007 E.03565
G3 X85.772 Y81.642 I4.734 J4.601 E.04894
G1 X86.041 Y81.202 E.0107
G2 X85.42 Y79.366 I-3.15 J.043 E.04087
G2 X83.511 Y78 I-4.734 J4.601 E.04894
G1 X83.232 Y77.545 E.01107
G3 X83.863 Y75.724 I3.964 J.354 E.04037
G3 X85.772 Y74.358 I4.734 J4.601 E.04894
G1 X86.039 Y73.922 E.01061
G2 X85.399 Y72.96 I-.696 J-.232 E.02762
G1 X81.778 Y72.993 E.0751
G3 X79.87 Y74.358 I-4.734 J-4.601 E.04894
G1 X79.591 Y74.814 E.01107
G2 X80.222 Y76.634 I3.964 J-.354 E.04037
G2 X82.131 Y78 I4.734 J-4.601 E.04894
G1 X82.409 Y78.455 E.01107
G3 X81.778 Y80.276 I-3.964 J-.354 E.04037
G3 X79.87 Y81.642 I-4.735 J-4.601 E.04894
G1 X79.591 Y82.097 E.01107
G2 X79.793 Y83.042 I1.83 J.102 E.02028
G1 X76.58 Y83.007 E.06665
G3 X78.489 Y81.642 I4.734 J4.601 E.04894
G1 X78.768 Y81.186 E.01107
G2 X78.137 Y79.366 I-3.964 J.354 E.04037
G2 X76.228 Y78 I-4.734 J4.601 E.04894
G1 X75.958 Y77.56 E.01071
G3 X76.58 Y75.724 I3.153 J.045 E.04086
G3 X78.489 Y74.358 I4.735 J4.601 E.04894
G1 X78.768 Y73.903 E.01107
G2 X78.566 Y72.96 I-1.826 J-.102 E.02024
G1 X76.869 Y72.961 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.566 Y72.96 E-.64486
G1 X78.666 Y73.247 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 24/73
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.24 I-.749 J.959 P1  F42000
G1 X102.54 Y91.89 Z3.24
G1 Z2.96
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X100.96 Y91.89 E-.60084
G1 X100.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.36 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 24 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer24 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X101.165 Y91.5
G1 Z2.96
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5985
M204 S6000
G1 X102.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X101.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.996 Y99.087 Z3.36 F42000
G1 X102.581 Y104.431 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5985
M204 S6000
G1 X101.819 Y104.431 E.0158
G1 X101.819 Y92.869 E.23982
G1 X102.581 Y92.869 E.0158
G1 X102.581 Y104.371 E.23857
M204 S250
G1 X102.99 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X101.41 Y104.84 E.03046
G1 X101.41 Y92.46 E.23863
G1 X102.99 Y92.46 E.03046
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F5985
M204 S6000
G1 X102.2 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X102.2 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.434 Y102.71 Z3.36 F42000
G1 X102.54 Y106.19 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5985
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.705 Y105.988 Z3.36 F42000
G1 X86.54 Y106.19 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5985
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.347 Y104.431 Z3.36 F42000
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5985
M204 S6000
G1 X84.919 Y104.431 E.00887
G1 X84.919 Y92.869 E.23982
G1 X85.681 Y92.869 E.0158
G1 X85.681 Y104.431 E.23982
G1 X85.407 Y104.431 E.00569
M204 S250
G1 X85.347 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X84.51 Y104.84 E.01613
G1 X84.51 Y92.46 E.23863
G1 X86.09 Y92.46 E.03046
G1 X86.09 Y104.84 E.23863
G1 X85.407 Y104.84 E.01317
M204 S10000
G1 X85.3 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F5985
M204 S6000
G1 X85.3 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X85.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.36 I1.134 J.441 P1  F42000
G1 X86.54 Y91.89 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
M204 S10000
G1 X86.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5985
M204 S6000
G1 X85.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X86.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X90.679 Y85.224 Z3.36 F42000
G1 X91.107 Y84.607 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5985
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5985
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3.36 F42000
G1 X103.14 Y85.44 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
M73 P45 R6
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.36 F42000
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5985
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5985
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.983 Y82.948 Z3.36 F42000
G1 X85.375 Y83.391 Z3.36
G1 Z2.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5985
M204 S6000
G1 X76.625 Y83.391 E.18151
G3 X75.609 Y82.375 I-.006 J-1.009 E.03315
G1 X75.609 Y73.625 E.18151
G3 X76.625 Y72.609 I1.005 J-.01 E.03319
G1 X85.414 Y72.61 E.1823
G3 X86.391 Y73.625 I-.031 J1.008 E.03235
G1 X86.391 Y82.375 E.18151
G3 X85.435 Y83.39 I-1.009 J.006 E.03191
M204 S10000
G1 X85.382 Y83.815 F42000
G1 F5985
M204 S6000
G1 X76.618 Y83.815 E.18179
G3 X75.185 Y82.382 I.003 J-1.436 E.04667
G1 X75.185 Y73.618 E.18179
G3 X76.618 Y72.185 I1.431 J-.002 E.04671
G1 X85.421 Y72.186 E.18259
G3 X86.815 Y73.618 I-.04 J1.434 E.04587
G1 X86.815 Y82.382 E.18179
G3 X85.442 Y83.814 I-1.436 J-.003 E.04543
M204 S250
G1 X85.389 Y84.225 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5985
M204 S5000
G1 X76.611 Y84.225 E.1692
G3 X74.775 Y82.389 I.011 J-1.847 E.05549
G1 X74.775 Y73.611 E.1692
G3 X76.611 Y71.775 I1.842 J.006 E.05553
G1 X85.427 Y71.777 E.16994
G3 X87.225 Y73.611 I-.049 J1.845 E.05474
G1 X87.225 Y82.389 E.1692
G3 X85.449 Y84.223 I-1.847 J-.011 E.05433
; WIPE_START
G1 F12000
M204 S6000
G1 X83.449 Y84.223 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.161 Y83.028 Z3.36 F42000
G1 Z2.96
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5985
M204 S6000
G1 X83.858 Y83.028 E.0352
G3 X84.251 Y82.552 I1.341 J.706 E.01289
G1 X85.487 Y81.642 E.03185
G1 X85.83 Y81.186 E.01181
G2 X85.032 Y78.91 I-2.623 J-.359 E.05194
G1 X83.796 Y78 E.03185
G1 X83.454 Y77.545 E.01181
G3 X84.251 Y75.269 I2.623 J-.359 E.05194
G1 X85.487 Y74.358 E.03185
G1 X85.83 Y73.903 E.01181
G1 X85.884 Y73.448 E.00951
G2 X85.395 Y72.973 I-.451 J-.025 E.01602
G1 X81.782 Y72.974 E.07493
G3 X81.391 Y73.448 I-1.336 J-.704 E.01285
G1 X80.154 Y74.358 E.03185
G1 X79.812 Y74.814 E.01181
G2 X80.609 Y77.09 I2.623 J.359 E.05194
G1 X81.846 Y78 E.03185
G1 X82.188 Y78.455 E.01181
G3 X81.391 Y80.731 I-2.623 J.359 E.05194
G1 X80.154 Y81.642 E.03185
G2 X79.876 Y83.028 I.823 J.886 E.03133
G1 X76.577 Y83.025 E.06843
G3 X76.968 Y82.552 I1.332 J.703 E.01281
G1 X78.204 Y81.642 E.03185
G1 X78.547 Y81.186 E.01181
G2 X77.749 Y78.91 I-2.623 J-.359 E.05194
G1 X76.513 Y78 E.03185
G1 X76.17 Y77.545 E.01181
G3 X76.968 Y75.269 I2.623 J-.359 E.05194
G1 X78.204 Y74.358 E.03185
G2 X78.483 Y72.974 I-.822 J-.886 E.03128
G1 X76.786 Y72.975 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.483 Y72.974 E-.64486
G1 X78.556 Y73.268 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 25/73
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.36 I-.746 J.961 P1  F42000
G1 X102.54 Y91.89 Z3.36
G1 Z3.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X100.96 Y91.89 E-.60084
G1 X100.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.48 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 25 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer25 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X101.165 Y91.5
G1 Z3.08
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5954
M204 S6000
G1 X102.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X101.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.996 Y99.087 Z3.48 F42000
G1 X102.581 Y104.431 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5954
M204 S6000
G1 X101.819 Y104.431 E.0158
G1 X101.819 Y92.869 E.23982
G1 X102.581 Y92.869 E.0158
G1 X102.581 Y104.371 E.23857
M204 S250
G1 X102.99 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X101.41 Y104.84 E.03046
G1 X101.41 Y92.46 E.23863
G1 X102.99 Y92.46 E.03046
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F5954
M204 S6000
G1 X102.2 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X102.2 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.434 Y102.71 Z3.48 F42000
G1 X102.54 Y106.19 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5954
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.705 Y105.988 Z3.48 F42000
G1 X86.54 Y106.19 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5954
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.344 Y104.431 Z3.48 F42000
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5954
M204 S6000
G1 X84.919 Y104.431 E.00881
G1 X84.919 Y92.869 E.23982
G1 X85.681 Y92.869 E.0158
G1 X85.681 Y104.431 E.23982
G1 X85.404 Y104.431 E.00574
M204 S250
G1 X85.344 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X84.51 Y104.84 E.01608
G1 X84.51 Y92.46 E.23863
G1 X86.09 Y92.46 E.03046
G1 X86.09 Y104.84 E.23863
G1 X85.404 Y104.84 E.01322
M204 S10000
G1 X85.3 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
M73 P46 R6
G1 F5954
M204 S6000
G1 X85.3 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X85.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.54 Y91.89 Z3.48 F42000
G1 Z3.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
M204 S10000
G1 X86.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5954
M204 S6000
G1 X85.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X86.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X90.679 Y85.224 Z3.48 F42000
G1 X91.107 Y84.607 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5954
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5954
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3.48 F42000
G1 X103.14 Y85.44 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.48 F42000
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5954
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5954
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.983 Y82.943 Z3.48 F42000
G1 X85.368 Y83.378 Z3.48
G1 Z3.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5954
M204 S6000
G1 X76.632 Y83.378 E.18122
G3 X75.622 Y82.368 I-.01 J-.999 E.03297
G1 X75.622 Y73.632 E.18122
G3 X76.631 Y72.622 I.999 J-.01 E.03297
G1 X85.409 Y72.624 E.18208
G3 X86.378 Y73.632 I-.029 J.997 E.03212
G1 X86.378 Y82.368 E.18122
G3 X85.428 Y83.376 I-.999 J.01 E.03172
M204 S10000
G1 X85.375 Y83.802 F42000
G1 F5954
M204 S6000
G1 X76.625 Y83.802 E.18152
G3 X75.198 Y82.375 I-.001 J-1.425 E.04648
G1 X75.198 Y73.625 E.18152
G3 X76.625 Y72.198 I1.424 J-.002 E.04649
G1 X85.416 Y72.2 E.18236
G3 X86.802 Y73.625 I-.037 J1.422 E.04564
G1 X86.802 Y82.375 E.18152
G3 X85.435 Y83.801 I-1.425 J.001 E.04524
M204 S250
G1 X85.382 Y84.211 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5954
M204 S5000
G1 X76.618 Y84.211 E.16894
G3 X74.789 Y82.382 I.007 J-1.836 E.05532
G1 X74.789 Y73.618 E.16894
G3 X76.618 Y71.789 I1.835 J.006 E.05532
G1 X85.423 Y71.79 E.16972
G3 X87.211 Y73.618 I-.046 J1.833 E.05454
G1 X87.211 Y82.382 E.16894
G3 X85.442 Y84.21 I-1.836 J-.007 E.05416
; WIPE_START
G1 F12000
M204 S6000
G1 X83.442 Y84.21 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.168 Y83.015 Z3.48 F42000
G1 Z3.08
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5954
M204 S6000
G1 X83.865 Y83.015 E.0352
G3 X84.202 Y82.552 I1.284 J.582 E.01196
G1 X85.284 Y81.642 E.02933
G1 X85.651 Y81.186 E.01213
G2 X85.081 Y78.91 I-2.314 J-.63 E.05085
G1 X83.999 Y78 E.02933
G1 X83.632 Y77.545 E.01213
G3 X84.202 Y75.269 I2.314 J-.63 E.05085
G1 X85.284 Y74.358 E.02933
G2 X85.765 Y73.448 I-.744 J-.975 E.02204
G2 X85.39 Y72.987 I-.308 J-.133 E.01516
G1 X81.776 Y72.987 E.07496
G3 X81.44 Y73.448 I-1.281 J-.581 E.01192
G1 X80.358 Y74.358 E.02933
G1 X79.991 Y74.814 E.01213
G2 X80.561 Y77.09 I2.314 J.63 E.05085
G1 X81.643 Y78 E.02933
G1 X82.009 Y78.455 E.01213
G3 X81.44 Y80.731 I-2.314 J.63 E.05085
G1 X80.358 Y81.642 E.02933
G2 X79.905 Y83.015 I.84 J1.038 E.03169
G1 X76.583 Y83.011 E.06889
G3 X76.919 Y82.552 I1.275 J.58 E.01188
G1 X78.001 Y81.642 E.02933
G1 X78.368 Y81.186 E.01213
G2 X77.798 Y78.91 I-2.314 J-.63 E.05085
G1 X76.716 Y78 E.02933
G1 X76.349 Y77.545 E.01213
G3 X76.919 Y75.269 I2.314 J-.63 E.05085
G1 X78.001 Y74.358 E.02933
G2 X78.454 Y72.988 I-.837 J-1.038 E.03165
G1 X76.757 Y72.988 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.454 Y72.988 E-.64486
G1 X78.472 Y73.29 E-.11515
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 26/73
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.48 I-.744 J.963 P1  F42000
G1 X102.54 Y91.89 Z3.48
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X100.96 Y91.89 E-.60084
G1 X100.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 26 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer26 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X101.165 Y91.5
G1 Z3.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5940
M204 S6000
G1 X102.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X101.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.996 Y99.087 Z3.6 F42000
G1 X102.581 Y104.431 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5940
M204 S6000
G1 X101.819 Y104.431 E.0158
G1 X101.819 Y92.869 E.23982
G1 X102.581 Y92.869 E.0158
G1 X102.581 Y104.371 E.23857
M204 S250
G1 X102.99 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X101.41 Y104.84 E.03046
G1 X101.41 Y92.46 E.23863
G1 X102.99 Y92.46 E.03046
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F5940
M204 S6000
G1 X102.2 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X102.2 Y95.081 E-.76
; WIPE_END
M73 P47 R6
G1 E-.04 F1800
M204 S10000
G1 X102.434 Y102.71 Z3.6 F42000
G1 X102.54 Y106.19 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5940
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.705 Y105.988 Z3.6 F42000
G1 X86.54 Y106.19 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5940
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.342 Y104.431 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5940
M204 S6000
G1 X84.919 Y104.431 E.00876
G1 X84.919 Y92.869 E.23982
G1 X85.681 Y92.869 E.0158
G1 X85.681 Y104.431 E.23982
G1 X85.402 Y104.431 E.00579
M204 S250
G1 X85.342 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X84.51 Y104.84 E.01603
G1 X84.51 Y92.46 E.23863
G1 X86.09 Y92.46 E.03046
G1 X86.09 Y104.84 E.23863
G1 X85.402 Y104.84 E.01327
M204 S10000
G1 X85.3 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.363042
G1 F5940
M204 S6000
G1 X85.3 Y93.081 E.18366
; WIPE_START
G1 F21000
G1 X85.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.54 Y91.89 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
M204 S10000
G1 X86.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5940
M204 S6000
G1 X85.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X86.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X90.679 Y85.224 Z3.6 F42000
G1 X91.107 Y84.607 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5940
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5940
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3.6 F42000
G1 X103.14 Y85.44 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5940
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5940
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.983 Y82.937 Z3.6 F42000
G1 X85.362 Y83.364 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5940
M204 S6000
G1 X76.638 Y83.364 E.18094
G3 X75.636 Y82.362 I-.006 J-.996 E.03271
G1 X75.636 Y73.638 E.18094
G3 X76.638 Y72.636 I.996 J-.006 E.03271
G1 X85.404 Y72.637 E.18183
G3 X86.364 Y73.638 I-.03 J.99 E.03186
G1 X86.364 Y82.362 E.18094
G3 X85.422 Y83.363 I-.996 J.006 E.03147
M204 S10000
G1 X85.369 Y83.788 F42000
G1 F5940
M204 S6000
G1 X76.631 Y83.788 E.18124
G3 X75.212 Y82.369 I.003 J-1.422 E.04622
G1 X75.212 Y73.631 E.18124
G3 X76.631 Y72.212 I1.422 J.003 E.04622
G1 X85.411 Y72.213 E.18212
G3 X86.788 Y73.631 I-.039 J1.415 E.04538
G1 X86.788 Y82.369 E.18124
G3 X85.429 Y83.787 I-1.422 J-.003 E.04498
M204 S250
G1 X85.375 Y84.197 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5940
M204 S5000
G1 X76.625 Y84.197 E.16868
G3 X74.803 Y82.375 I.012 J-1.834 E.05507
G1 X74.803 Y73.625 E.16868
G3 X76.625 Y71.803 I1.834 J.012 E.05507
G1 X85.418 Y71.804 E.1695
G3 X87.197 Y73.625 I-.048 J1.826 E.05429
G1 X87.197 Y82.375 E.16868
G3 X85.435 Y84.196 I-1.834 J-.012 E.05392
; WIPE_START
G1 F12000
M204 S6000
G1 X83.435 Y84.196 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.558 Y82.969 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5940
M204 S6000
G1 X85.501 Y82.987 E.00124
G3 X83.864 Y83.001 I-.896 J-8.777 E.034
G1 X84.15 Y82.552 E.01105
G2 X85.5 Y81.186 I-4.966 J-6.255 E.03991
G2 X85.133 Y78.91 I-2.106 J-.828 E.05017
G3 X83.784 Y77.545 I4.965 J-6.255 E.03991
G3 X84.15 Y75.269 I2.106 J-.828 E.05017
G1 X85.119 Y74.358 E.02758
G2 X85.672 Y73.081 I-1.086 J-1.229 E.02982
G2 X85.385 Y73 I-.316 J.575 E.00624
G1 X81.776 Y73.001 E.07486
G1 X81.491 Y73.448 E.011
G2 X80.142 Y74.814 I4.965 J6.254 E.03991
G2 X80.509 Y77.09 I2.106 J.828 E.05017
G3 X81.858 Y78.455 I-4.965 J6.254 E.03991
G3 X81.491 Y80.731 I-2.106 J.828 E.05017
G1 X80.522 Y81.642 E.02758
G2 X79.966 Y83.001 I1.119 J1.251 E.03153
G1 X76.584 Y82.997 E.07017
G1 X76.867 Y82.552 E.01095
G2 X78.216 Y81.186 I-4.965 J-6.255 E.03991
G2 X77.85 Y78.91 I-2.106 J-.828 E.05017
G3 X76.501 Y77.545 I4.966 J-6.255 E.03991
G3 X76.867 Y75.269 I2.106 J-.828 E.05017
G1 X77.836 Y74.358 E.02758
G2 X78.392 Y73.001 I-1.118 J-1.25 E.03148
G1 X76.695 Y73.002 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.392 Y73.001 E-.64486
M73 P48 R6
G1 X78.381 Y73.304 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 27/73
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.6 I-.742 J.965 P1  F42000
G1 X102.54 Y91.89 Z3.6
G1 Z3.32
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6285
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X100.96 Y91.89 E-.60084
G1 X100.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.72 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 27 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer27 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X101.165 Y91.5
G1 Z3.32
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6285
M204 S6000
G1 X102.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X101.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.199 Y99.062 Z3.72 F42000
G1 X102.99 Y104.84 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6285
M204 S5000
G1 X101.41 Y104.84 E.03046
G1 X101.41 Y92.46 E.23863
G1 X102.99 Y92.46 E.03046
G1 X102.99 Y104.78 E.23748
; WIPE_START
G1 F12000
M204 S6000
G1 X101.41 Y104.84 E-.60084
G1 X101.41 Y104.421 E-.15917
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.352 Y96.847 Z3.72 F42000
G1 X102.773 Y93.456 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Top surface
G1 F6285
M204 S2000
G1 X101.994 Y92.677 E.02124
G1 X101.627 Y92.867
G1 X102.773 Y94.014 E.03125
G1 X102.773 Y94.571
G1 X101.627 Y93.425 E.03125
G1 X101.627 Y93.982
G1 X102.773 Y95.129 E.03125
G1 X102.773 Y95.686
G1 X101.627 Y94.54 E.03125
G1 X101.627 Y95.097
G1 X102.773 Y96.244 E.03125
G1 X102.773 Y96.801
G1 X101.627 Y95.655 E.03125
G1 X101.627 Y96.212
G1 X102.773 Y97.359 E.03125
G1 X102.773 Y97.916
G1 X101.627 Y96.77 E.03125
G1 X101.627 Y97.328
G1 X102.773 Y98.474 E.03125
G1 X102.773 Y99.031
G1 X101.627 Y97.885 E.03125
G1 X101.627 Y98.443
G1 X102.773 Y99.589 E.03125
G1 X102.773 Y100.146
G1 X101.627 Y99 E.03125
G1 X101.627 Y99.558
G1 X102.773 Y100.704 E.03125
G1 X102.773 Y101.262
G1 X101.627 Y100.115 E.03125
G1 X101.627 Y100.673
G1 X102.773 Y101.819 E.03125
G1 X102.773 Y102.377
G1 X101.627 Y101.23 E.03125
G1 X101.627 Y101.788
G1 X102.773 Y102.934 E.03125
G1 X102.773 Y103.492
G1 X101.627 Y102.345 E.03125
G1 X101.627 Y102.903
G1 X102.773 Y104.049 E.03125
G1 X102.773 Y104.607
G1 X101.627 Y103.46 E.03125
G1 X101.627 Y104.018
G1 X102.232 Y104.623 E.0165
; WIPE_START
G1 F12000
M204 S6000
G1 X101.627 Y104.018 E-.32522
G1 X101.627 Y103.46 E-.21187
G1 X102.042 Y103.875 E-.22291
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.54 Y106.19 Z3.72 F42000
G1 Z3.32
G1 E.8 F1800
; FEATURE: Outer wall
G1 F6285
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6285
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.705 Y105.988 Z3.72 F42000
G1 X86.54 Y106.19 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6285
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6285
M204 S6000
G1 X85.165 Y105.8 E.02122
M204 S250
G1 X85.339 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6285
M204 S5000
G1 X84.51 Y104.84 E.01598
G1 X84.51 Y92.46 E.23863
G1 X86.09 Y92.46 E.03046
G1 X86.09 Y104.84 E.23863
G1 X85.399 Y104.84 E.01332
; WIPE_START
G1 F12000
M204 S6000
G1 X84.51 Y104.84 E-.33788
G1 X84.51 Y103.729 E-.42212
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.032 Y96.115 Z3.72 F42000
G1 X85.268 Y92.677 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Top surface
G1 F6285
M204 S2000
G1 X85.873 Y93.282 E.0165
G1 X85.873 Y93.84
G1 X84.727 Y92.693 E.03125
G1 X84.727 Y93.251
G1 X85.873 Y94.397 E.03125
G1 X85.873 Y94.955
G1 X84.727 Y93.808 E.03125
G1 X84.727 Y94.366
G1 X85.873 Y95.512 E.03125
G1 X85.873 Y96.07
G1 X84.727 Y94.924 E.03125
G1 X84.727 Y95.481
G1 X85.873 Y96.627 E.03125
G1 X85.873 Y97.185
G1 X84.727 Y96.039 E.03125
G1 X84.727 Y96.596
G1 X85.873 Y97.742 E.03125
G1 X85.873 Y98.3
G1 X84.727 Y97.154 E.03125
G1 X84.727 Y97.711
G1 X85.873 Y98.858 E.03125
G1 X85.873 Y99.415
G1 X84.727 Y98.269 E.03125
G1 X84.727 Y98.826
G1 X85.873 Y99.973 E.03125
G1 X85.873 Y100.53
G1 X84.727 Y99.384 E.03125
G1 X84.727 Y99.941
G1 X85.873 Y101.088 E.03125
G1 X85.873 Y101.645
G1 X84.727 Y100.499 E.03125
G1 X84.727 Y101.056
G1 X85.873 Y102.203 E.03125
G1 X85.873 Y102.76
G1 X84.727 Y101.614 E.03125
G1 X84.727 Y102.172
G1 X85.873 Y103.318 E.03125
G1 X85.873 Y103.875
G1 X84.727 Y102.729 E.03125
G1 X84.727 Y103.287
G1 X85.873 Y104.433 E.03125
G1 X85.506 Y104.623
G1 X84.727 Y103.844 E.02124
; WIPE_START
G1 F12000
M204 S6000
G1 X85.506 Y104.623 E-.41864
G1 X85.873 Y104.433 E-.15719
G1 X85.53 Y104.09 E-.18417
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.16 Y96.484 Z3.72 F42000
G1 X86.54 Y91.89 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Outer wall
G1 F6285
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
M204 S10000
G1 X86.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6285
M204 S6000
G1 X85.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X86.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X90.679 Y85.224 Z3.72 F42000
G1 X91.107 Y84.607 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6285
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F6285
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3.72 F42000
G1 X103.14 Y85.44 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6285
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
M73 P49 R6
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.72 F42000
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6285
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F6285
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6285
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.983 Y82.931 Z3.72 F42000
G1 X85.355 Y83.35 Z3.72
G1 Z3.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6285
M204 S6000
G1 X76.645 Y83.35 E.18066
G3 X75.65 Y82.355 I-.006 J-.989 E.03249
G1 X75.65 Y73.645 E.18066
G3 X76.645 Y72.65 I.985 J-.011 E.03253
G1 X85.4 Y72.651 E.18161
G3 X86.35 Y73.645 I-.033 J.983 E.03159
G1 X86.35 Y82.355 E.18066
G3 X85.415 Y83.349 I-.989 J.006 E.03125
M204 S10000
G1 X85.362 Y83.775 F42000
G1 F6285
M204 S6000
G1 X76.638 Y83.775 E.18095
G3 X75.225 Y82.362 I.003 J-1.416 E.046
G1 X75.225 Y73.638 E.18095
G3 X76.638 Y72.225 I1.411 J-.002 E.04605
G1 X85.407 Y72.227 E.18189
G3 X86.775 Y73.638 I-.042 J1.409 E.04511
G1 X86.775 Y82.362 E.18095
G3 X85.422 Y83.773 I-1.416 J-.003 E.04476
M204 S250
G1 X85.369 Y84.184 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6285
M204 S5000
G1 X76.631 Y84.184 E.16841
G3 X74.816 Y82.369 I.012 J-1.827 E.05487
G1 X74.816 Y73.631 E.16841
G3 X76.631 Y71.816 I1.821 J.006 E.05492
G1 X85.414 Y71.818 E.16928
G3 X87.184 Y73.631 I-.05 J1.82 E.05404
G1 X87.184 Y82.369 E.16841
G3 X85.428 Y84.183 I-1.827 J-.012 E.05372
; WIPE_START
G1 F12000
M204 S6000
G1 X83.428 Y84.183 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.55 Y82.956 Z3.72 F42000
G1 Z3.32
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6285
M204 S6000
G1 X85.493 Y82.973 E.00124
G3 X83.856 Y82.988 I-.896 J-8.779 E.034
G3 X84.976 Y81.642 I3.797 J2.02 E.03657
G2 X85.62 Y80.276 I-1.29 J-1.443 E.03217
G2 X84.307 Y78 I-2.954 J.187 E.05647
G3 X83.663 Y76.634 I1.29 J-1.442 E.03217
G3 X84.976 Y74.358 I2.954 J.187 E.05647
G2 X85.611 Y73.064 I-1.261 J-1.422 E.03068
G2 X85.38 Y73.014 I-.3 J.827 E.00492
G1 X81.784 Y73.014 E.07459
G3 X80.665 Y74.358 I-3.796 J-2.022 E.03653
G2 X80.022 Y75.724 I1.29 J1.442 E.03217
G2 X81.335 Y78 I2.954 J-.187 E.05647
G3 X81.978 Y79.366 I-1.29 J1.442 E.03217
G3 X80.665 Y81.642 I-2.954 J-.187 E.05647
G2 X80.024 Y82.988 I1.281 J1.436 E.03176
G1 X76.576 Y82.983 E.07152
G3 X77.693 Y81.642 I3.794 J2.024 E.03646
G2 X78.337 Y80.276 I-1.29 J-1.443 E.03217
G2 X77.024 Y78 I-2.954 J.187 E.05647
G3 X76.38 Y76.634 I1.29 J-1.443 E.03217
G3 X77.693 Y74.358 I2.954 J.187 E.05647
G2 X78.334 Y73.015 I-1.28 J-1.436 E.03171
G1 X76.637 Y73.015 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.334 Y73.015 E-.64486
G1 X78.298 Y73.315 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 28/73
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.72 I-1.112 J.494 P1  F42000
G1 X86.54 Y91.89 Z3.72
G1 Z3.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.84 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 28 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer28 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z3.44
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5302
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z3.84 F42000
G1 X85.29 Y104.84 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5302
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z3.84 F42000
G1 X86.54 Y106.19 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5302
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z3.84 F42000
G1 X102.54 Y106.19 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5302
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z3.84 F42000
G1 Z3.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5302
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5302
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z3.84 F42000
G1 X91.107 Y84.607 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5302
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5302
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P50 R6
G1 X97.966 Y84.935 Z3.84 F42000
G1 X103.14 Y85.44 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.84 F42000
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5302
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5302
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.983 Y82.925 Z3.84 F42000
G1 X85.348 Y83.337 Z3.84
G1 Z3.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5302
M204 S6000
G1 X76.652 Y83.337 E.18038
G3 X75.663 Y82.348 I-.011 J-.978 E.03231
G1 X75.663 Y73.652 E.18038
G3 X76.652 Y72.663 I.978 J-.011 E.03231
G1 X85.395 Y72.665 E.18136
G3 X86.337 Y73.652 I-.035 J.976 E.03133
G1 X86.337 Y82.348 E.18038
G3 X85.408 Y83.336 I-.978 J.011 E.03107
M204 S10000
G1 X85.355 Y83.761 F42000
G1 F5302
M204 S6000
G1 X76.645 Y83.761 E.18067
G3 X75.239 Y82.355 I-.002 J-1.404 E.04583
G1 X75.239 Y73.645 E.18067
G3 X76.645 Y72.239 I1.404 J-.002 E.04583
G1 X85.402 Y72.24 E.18166
G3 X86.761 Y73.645 I-.044 J1.402 E.04484
G1 X86.761 Y82.355 E.18067
G3 X85.415 Y83.76 I-1.404 J.002 E.04459
M204 S250
G1 X85.362 Y84.17 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5302
M204 S5000
G1 X76.638 Y84.17 E.16815
G3 X74.83 Y82.362 I.006 J-1.815 E.05471
G1 X74.83 Y73.638 E.16815
G3 X76.638 Y71.83 I1.815 J.006 E.05471
G1 X85.409 Y71.831 E.16907
G3 X87.17 Y73.638 I-.052 J1.813 E.05379
G1 X87.17 Y82.362 E.16815
G3 X85.422 Y84.169 I-1.815 J-.006 E.05356
; WIPE_START
G1 F12000
M204 S6000
G1 X83.422 Y84.17 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.535 Y82.945 Z3.84 F42000
G1 Z3.44
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5302
M204 S6000
G1 X85.484 Y82.96 E.00109
G3 X83.841 Y82.974 I-.898 J-8.838 E.03415
G3 X84.846 Y81.642 I3.372 J1.5 E.03493
G2 X84.895 Y78.455 I-1.453 J-1.616 E.0742
G3 X83.803 Y77.09 I2.797 J-3.357 E.03652
G3 X84.846 Y74.358 I2.524 J-.601 E.06443
G2 X85.558 Y73.062 I-1.463 J-1.647 E.03128
G2 X85.375 Y73.027 I-.185 J.473 E.00388
G1 X81.8 Y73.028 E.07415
G3 X80.795 Y74.358 I-3.371 J-1.501 E.03489
G2 X80.747 Y77.545 I1.453 J1.616 E.0742
G3 X81.839 Y78.91 I-2.797 J3.358 E.03652
G3 X80.795 Y81.642 I-2.524 J.601 E.06443
G2 X80.077 Y82.974 I1.476 J1.657 E.03205
G1 X76.56 Y82.968 E.07293
G3 X77.563 Y81.642 I3.368 J1.504 E.03478
G2 X77.612 Y78.455 I-1.453 J-1.616 E.0742
G3 X76.52 Y77.09 I2.797 J-3.358 E.03652
G3 X77.563 Y74.358 I2.524 J-.601 E.06443
G2 X78.282 Y73.028 I-1.475 J-1.656 E.032
G1 X76.585 Y73.032 E.03519
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.282 Y73.028 E-.64474
G1 X78.222 Y73.326 E-.11526
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 29/73
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.84 I-1.111 J.498 P1  F42000
G1 X86.54 Y91.89 Z3.84
G1 Z3.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.96 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 29 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer29 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z3.56
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5295
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z3.96 F42000
G1 X85.29 Y104.84 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5295
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z3.96 F42000
G1 X86.54 Y106.19 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5295
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z3.96 F42000
G1 X102.54 Y106.19 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5295
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z3.96 F42000
G1 Z3.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5295
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
M73 P51 R6
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5295
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z3.96 F42000
G1 X91.107 Y84.607 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5295
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5295
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z3.96 F42000
G1 X103.14 Y85.44 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z3.96 F42000
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5295
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5295
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.982 Y82.92 Z3.96 F42000
G1 X85.341 Y83.323 Z3.96
G1 Z3.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5295
M204 S6000
G1 X76.659 Y83.323 E.1801
G3 X75.677 Y82.341 I-.014 J-.968 E.03213
G1 X75.677 Y73.658 E.1801
G3 X76.293 Y72.743 I.974 J-.009 E.02435
G3 X76.658 Y72.677 I.375 J1.026 E.00773
G1 X85.391 Y72.678 E.18113
G3 X85.86 Y72.818 I-.031 J.958 E.01026
G3 X86.323 Y73.659 I-.504 J.827 E.02084
G1 X86.323 Y82.342 E.1801
G3 X85.401 Y83.322 I-.968 J.014 E.03088
M204 S10000
G1 X85.348 Y83.748 F42000
G1 F5295
M204 S6000
G1 X76.652 Y83.748 E.18039
G3 X75.252 Y82.348 I-.007 J-1.392 E.04566
G1 X75.252 Y73.652 E.18039
G3 X76.652 Y72.252 I1.394 J-.005 E.04563
G1 X85.398 Y72.254 E.18142
G3 X86.748 Y73.652 I-.044 J1.393 E.0446
G1 X86.748 Y82.348 E.18039
G3 X85.408 Y83.747 I-1.392 J.007 E.04442
M204 S250
G1 X85.355 Y84.157 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5295
M204 S5000
M73 P51 R5
G1 X76.645 Y84.157 E.16789
G3 X74.843 Y82.355 I-.001 J-1.801 E.05456
G1 X74.843 Y73.645 E.16789
G3 X76.645 Y71.843 I1.8 J-.002 E.05457
G1 X85.405 Y71.845 E.16885
G3 X87.157 Y73.645 I-.052 J1.803 E.05357
G1 X87.157 Y82.355 E.16789
G3 X85.415 Y84.156 I-1.801 J.001 E.05341
; WIPE_START
G1 F12000
M204 S6000
G1 X83.415 Y84.156 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.511 Y82.936 Z3.96 F42000
G1 Z3.56
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5295
M204 S6000
G1 X85.476 Y82.946 E.00076
G3 X83.817 Y82.961 I-.906 J-8.921 E.03448
G3 X84.723 Y81.642 I2.972 J1.072 E.03357
G2 X84.56 Y78 I-1.527 J-1.756 E.08687
G3 X84.723 Y74.358 I1.527 J-1.756 E.08687
G2 X85.511 Y73.065 I-1.695 J-1.917 E.03189
G2 X85.371 Y73.041 I-.135 J.372 E.00295
G1 X81.824 Y73.041 E.07357
G3 X80.918 Y74.358 I-2.971 J-1.074 E.03352
G2 X81.082 Y78 I1.527 J1.756 E.08687
G3 X80.918 Y81.642 I-1.527 J1.756 E.08687
G2 X80.124 Y82.961 I1.703 J1.924 E.03243
G1 X76.67 Y82.961 E.07165
G3 X76.539 Y82.947 I-.027 J-.391 E.00275
G3 X77.44 Y81.642 I2.963 J1.082 E.03327
G2 X77.277 Y78 I-1.527 J-1.756 E.08687
G3 X77.44 Y74.358 I1.527 J-1.756 E.08687
G2 X78.234 Y73.042 I-1.702 J-1.923 E.03238
G1 X76.538 Y73.054 E.03518
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.234 Y73.042 E-.64451
G1 X78.152 Y73.335 E-.11549
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 30/73
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.96 I-1.109 J.501 P1  F42000
G1 X86.54 Y91.89 Z3.96
G1 Z3.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.08 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 30 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer30 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z3.68
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5291
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.08 F42000
G1 X85.29 Y104.84 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5291
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.08 F42000
G1 X86.54 Y106.19 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P52 R5
G1 F5291
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5291
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.08 F42000
G1 X102.54 Y106.19 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5291
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.08 F42000
G1 Z3.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5291
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5291
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z4.08 F42000
G1 X91.107 Y84.607 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5291
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5291
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z4.08 F42000
G1 X103.14 Y85.44 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z4.08 F42000
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5291
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5291
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.982 Y82.914 Z4.08 F42000
G1 X85.335 Y83.31 Z4.08
G1 Z3.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5291
M204 S6000
G1 X76.665 Y83.31 E.17982
G3 X75.69 Y82.335 I-.011 J-.965 E.03187
G1 X75.69 Y73.665 E.17982
G3 X76.665 Y72.69 I.965 J-.011 E.03187
G1 X85.386 Y72.692 E.1809
G3 X86.31 Y73.665 I-.04 J.962 E.03079
G1 X86.31 Y82.335 E.17982
G3 X85.395 Y83.309 I-.965 J.011 E.03063
M204 S10000
G1 X85.342 Y83.734 F42000
G1 F5291
M204 S6000
G1 X76.658 Y83.734 E.18011
G3 X75.266 Y82.342 I-.002 J-1.39 E.04539
G1 X75.266 Y73.658 E.18011
G3 X76.658 Y72.266 I1.39 J-.002 E.04539
G1 X85.393 Y72.268 E.18119
G3 X86.734 Y73.658 I-.048 J1.388 E.04431
G1 X86.734 Y82.342 E.18011
G3 X85.402 Y83.733 I-1.39 J.002 E.04415
M204 S250
G1 X85.348 Y84.143 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5291
M204 S5000
G1 X76.652 Y84.143 E.16763
G3 X74.857 Y82.348 I.006 J-1.801 E.0543
G1 X74.857 Y73.652 E.16763
G3 X76.652 Y71.857 I1.801 J.006 E.0543
G1 X85.4 Y71.858 E.16863
G3 X87.143 Y73.652 I-.057 J1.799 E.0533
G1 X87.143 Y82.348 E.16763
G3 X85.408 Y84.142 I-1.801 J-.006 E.05315
; WIPE_START
G1 F12000
M204 S6000
G1 X83.408 Y84.142 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.48 Y82.929 Z4.08 F42000
G1 Z3.68
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5291
M204 S6000
G3 X85.318 Y82.947 I-.124 J-.388 E.00341
G1 X83.784 Y82.947 E.03181
G3 X84.603 Y81.642 I2.608 J.726 E.03241
G2 X84.68 Y78 I-1.375 J-1.851 E.0871
G3 X84.603 Y74.358 I1.375 J-1.851 E.0871
G2 X85.469 Y73.068 I-1.957 J-2.248 E.03261
G2 X85.366 Y73.055 I-.088 J.276 E.00215
G1 X81.857 Y73.055 E.0728
G3 X81.039 Y74.358 I-2.606 J-.727 E.03237
G2 X80.962 Y78 I1.375 J1.851 E.0871
G3 X81.039 Y81.642 I-1.375 J1.851 E.0871
G2 X80.167 Y82.947 I1.961 J2.251 E.03294
G1 X76.677 Y82.947 E.07241
G3 X76.508 Y82.925 I-.019 J-.508 E.00354
G3 X77.32 Y81.642 I2.595 J.743 E.03193
G2 X77.397 Y78 I-1.375 J-1.851 E.0871
G3 X77.32 Y74.358 I1.375 J-1.851 E.0871
G2 X78.19 Y73.055 I-1.96 J-2.251 E.03289
G1 X76.495 Y73.076 E.03517
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.19 Y73.055 E-.64428
G1 X78.088 Y73.342 E-.11572
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 31/73
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.08 I-1.107 J.505 P1  F42000
G1 X86.54 Y91.89 Z4.08
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
M73 P53 R5
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 31 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer31 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5288
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.2 F42000
G1 X85.29 Y104.84 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5288
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.2 F42000
G1 X86.54 Y106.19 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5288
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.2 F42000
G1 X102.54 Y106.19 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5288
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5288
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5288
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z4.2 F42000
G1 X91.107 Y84.607 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5288
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5288
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z4.2 F42000
G1 X103.14 Y85.44 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5288
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5288
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.982 Y82.908 Z4.2 F42000
G1 X85.328 Y83.296 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5288
M204 S6000
G1 X76.672 Y83.296 E.17954
G3 X75.704 Y82.328 I-.011 J-.958 E.03165
G1 X75.704 Y73.672 E.17954
G3 X76.672 Y72.704 I.958 J-.011 E.03165
G1 X85.382 Y72.705 E.18066
G3 X86.296 Y73.672 I-.038 J.952 E.03056
G1 X86.296 Y82.328 E.17954
G3 X85.388 Y83.295 I-.954 J.014 E.03044
M204 S10000
G1 X85.335 Y83.721 F42000
G1 F5288
M204 S6000
G1 X76.665 Y83.721 E.17983
G3 X75.279 Y82.335 I-.002 J-1.384 E.04517
G1 X75.279 Y73.665 E.17983
G3 X76.665 Y72.279 I1.384 J-.002 E.04517
G1 X85.389 Y72.281 E.18095
G3 X86.721 Y73.665 I-.045 J1.376 E.04409
G1 X86.721 Y82.335 E.17983
G3 X85.395 Y83.72 I-1.378 J.007 E.04397
M204 S250
G1 X85.342 Y84.13 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5288
M204 S5000
G1 X76.658 Y84.13 E.16737
G3 X76.022 Y84.013 I.041 J-2.012 E.01253
G3 X74.919 Y82.755 I.652 J-1.684 E.03353
G3 X74.87 Y82.342 I2.42 J-.495 E.00803
G1 X74.87 Y73.658 E.16737
G3 X76.658 Y71.87 I1.794 J.006 E.0541
G1 X85.395 Y71.872 E.16841
G3 X87.081 Y73.245 I-.051 J1.783 E.04507
G3 X87.13 Y73.658 I-2.42 J.495 E.00803
G1 X87.13 Y82.342 E.16737
G3 X85.755 Y84.081 I-1.786 J.001 E.04611
M73 P54 R5
G3 X85.401 Y84.127 I-.495 J-2.42 E.00687
; WIPE_START
G1 F12000
M204 S6000
G1 X83.401 Y84.128 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.44 Y82.922 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5288
M204 S6000
G3 X83.744 Y82.934 I-.913 J-9.115 E.03524
G3 X84.482 Y81.642 I2.28 J.445 E.03141
G2 X85.452 Y78.91 I-1.46 J-2.057 E.06405
G2 X84.352 Y77.545 I-4.265 J2.31 E.03657
G3 X84.482 Y74.358 I1.561 J-1.532 E.07412
G2 X85.431 Y73.076 I-2.247 J-2.655 E.03339
G1 X81.897 Y73.068 E.07329
G3 X81.16 Y74.358 I-2.279 J-.447 E.03137
G2 X80.19 Y77.09 I1.46 J2.057 E.06405
G2 X81.29 Y78.455 I4.265 J-2.31 E.03657
G3 X81.16 Y81.642 I-1.561 J1.532 E.07412
G2 X80.207 Y82.934 I2.248 J2.656 E.0336
G1 X76.683 Y82.934 E.07309
G3 X76.468 Y82.9 I-.01 J-.651 E.00453
G3 X77.199 Y81.642 I2.264 J.472 E.03071
G2 X78.169 Y78.91 I-1.46 J-2.057 E.06405
G2 X77.069 Y77.545 I-4.265 J2.31 E.03657
G3 X77.199 Y74.358 I1.561 J-1.532 E.07412
G2 X78.151 Y73.069 I-2.247 J-2.655 E.03356
G1 X76.631 Y73.069 E.03151
G2 X76.458 Y73.106 I.003 J.439 E.0037
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X76.631 Y73.069 E-.06725
G1 X78.151 Y73.069 E-.57734
G1 X78.029 Y73.347 E-.11542
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 32/73
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.2 I-1.106 J.508 P1  F42000
G1 X86.54 Y91.89 Z4.2
G1 Z3.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.32 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 32 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer32 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z3.92
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5287
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.32 F42000
G1 X85.29 Y104.84 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5287
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.32 F42000
G1 X86.54 Y106.19 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5287
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.32 F42000
G1 X102.54 Y106.19 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5287
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.32 F42000
G1 Z3.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5287
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5287
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z4.32 F42000
G1 X91.107 Y84.607 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5287
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5287
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z4.32 F42000
G1 X103.14 Y85.44 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z4.32 F42000
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5287
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5287
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.982 Y82.902 Z4.32 F42000
G1 X85.321 Y83.283 Z4.32
G1 Z3.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5287
M204 S6000
G1 X76.679 Y83.283 E.17927
G3 X75.717 Y82.321 I-.014 J-.948 E.03146
G1 X75.717 Y73.679 E.17927
G3 X76.679 Y72.717 I.951 J-.011 E.03143
G1 X85.377 Y72.719 E.18042
G1 X85.4 Y72.72 E.00048
G3 X86.283 Y73.679 I-.068 J.948 E.02979
M73 P55 R5
G1 X86.283 Y82.321 E.17927
G3 X85.555 Y83.257 I-.952 J.01 E.02654
G3 X85.381 Y83.28 I-.263 J-1.289 E.00364
M204 S10000
G1 X85.328 Y83.707 F42000
G1 F5287
M204 S6000
G1 X76.672 Y83.707 E.17955
G3 X76.349 Y83.67 I.057 J-1.904 E.00676
G3 X75.293 Y82.328 I.315 J-1.334 E.03823
G1 X75.293 Y73.672 E.17955
G3 X75.33 Y73.349 I1.904 J.057 E.00676
G3 X76.672 Y72.293 I1.34 J.323 E.03819
G1 X85.384 Y72.295 E.18071
G3 X86.707 Y73.672 I-.047 J1.369 E.04383
G1 X86.707 Y82.328 E.17955
G3 X86.67 Y82.651 I-1.904 J-.057 E.00676
G3 X85.388 Y83.706 I-1.334 J-.315 E.03698
M204 S250
G1 X85.335 Y84.116 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5287
M204 S5000
G1 X76.665 Y84.116 E.16711
G3 X74.884 Y82.335 I.006 J-1.788 E.05389
G1 X74.884 Y73.665 E.16711
G3 X76.665 Y71.884 I1.788 J.006 E.05389
G1 X85.391 Y71.886 E.16819
G3 X87.116 Y73.665 I-.053 J1.778 E.05286
G1 X87.116 Y82.335 E.16711
G3 X85.395 Y84.115 I-1.788 J-.006 E.05274
; WIPE_START
G1 F12000
M204 S6000
G1 X83.395 Y84.115 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.391 Y82.912 Z4.32 F42000
G1 Z3.92
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5287
M204 S6000
G3 X83.694 Y82.92 I-.892 J-9.103 E.03524
G3 X84.355 Y81.642 I1.985 J.216 E.03053
G2 X85.602 Y79.366 I-1.622 J-2.368 E.05586
G2 X84.928 Y78 I-2.032 J.153 E.03237
G3 X83.681 Y75.724 I1.622 J-2.368 E.05586
G3 X84.355 Y74.358 I2.032 J.153 E.03237
G2 X85.396 Y73.086 I-2.558 J-3.155 E.03433
G1 X81.947 Y73.082 E.07154
G3 X81.287 Y74.358 I-1.985 J-.217 E.03049
G2 X80.04 Y76.634 I1.622 J2.368 E.05586
G2 X80.713 Y78 I2.032 J-.153 E.03237
G3 X81.96 Y80.276 I-1.622 J2.368 E.05586
G3 X81.287 Y81.642 I-2.032 J-.153 E.03237
G2 X80.243 Y82.92 I2.558 J3.155 E.03448
G1 X76.69 Y82.92 E.07369
G3 X76.42 Y82.862 I.006 J-.681 E.00577
G3 X77.072 Y81.642 I1.965 J.265 E.02931
G2 X78.319 Y79.366 I-1.622 J-2.368 E.05586
G2 X77.645 Y78 I-2.032 J.153 E.03237
G3 X76.398 Y75.724 I1.622 J-2.368 E.05586
G3 X77.072 Y74.358 I2.032 J.153 E.03237
G2 X78.115 Y73.082 I-2.558 J-3.155 E.03442
G1 X76.63 Y73.083 E.0308
G2 X76.425 Y73.135 I.028 J.54 E.00441
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X76.63 Y73.083 E-.08027
G1 X78.115 Y73.082 E-.5642
G1 X77.975 Y73.352 E-.11553
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 33/73
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.32 I-1.105 J.51 P1  F42000
G1 X86.54 Y91.89 Z4.32
G1 Z4.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.44 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 33 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer33 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z4.04
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5289
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.44 F42000
G1 X85.29 Y104.84 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5289
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.44 F42000
G1 X86.54 Y106.19 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5289
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.44 F42000
G1 X102.54 Y106.19 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5289
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.44 F42000
G1 Z4.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5289
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5289
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z4.44 F42000
G1 X91.107 Y84.607 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5289
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5289
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.966 Y84.935 Z4.44 F42000
G1 X103.14 Y85.44 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X89.96 Y85.44 E.25405
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X103.14 Y85.06 E.21589
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X101.14 Y85.389 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z4.44 F42000
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5289
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5289
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X92.36 Y73.44 E.21589
G1 X92.36 Y73.06 E.00732
M73 P56 R5
G1 X105.54 Y73.06 E.25405
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.981 Y82.897 Z4.44 F42000
G1 X85.315 Y83.269 Z4.44
G1 Z4.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5289
M204 S6000
G1 X76.686 Y83.269 E.17898
G3 X75.731 Y82.314 I-.011 J-.944 E.03121
G1 X75.731 Y73.686 E.17898
G3 X76.685 Y72.731 I.944 J-.011 E.03121
G1 X85.373 Y72.733 E.1802
G1 X85.393 Y72.733 E.00041
G3 X86.269 Y73.686 I-.063 J.938 E.02961
G1 X86.269 Y82.314 E.17898
G3 X85.374 Y83.268 I-.944 J.011 E.02997
M204 S10000
G1 X85.321 Y83.694 F42000
G1 F5289
M204 S6000
G1 X76.679 Y83.694 E.17927
G3 X75.306 Y82.321 I-.002 J-1.37 E.04473
G1 X75.306 Y73.679 E.17927
G3 X76.679 Y72.306 I1.37 J-.002 E.04473
G1 X85.38 Y72.308 E.18048
G3 X86.694 Y73.679 I-.055 J1.368 E.04352
G1 X86.694 Y82.321 E.17927
G3 X85.381 Y83.692 I-1.37 J.002 E.04349
M204 S250
G1 X85.328 Y84.103 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5289
M204 S5000
G1 X76.672 Y84.103 E.16684
G3 X74.897 Y82.328 I-.001 J-1.774 E.05375
G1 X74.897 Y73.672 E.16685
G3 X76.672 Y71.897 I1.774 J-.001 E.05375
G1 X85.386 Y71.899 E.16798
G3 X87.103 Y73.672 I-.063 J1.778 E.05256
G1 X87.103 Y82.328 E.16685
G3 X85.388 Y84.102 I-1.774 J.001 E.0526
; WIPE_START
G1 F12000
M204 S6000
G1 X83.388 Y84.102 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.332 Y82.903 Z4.44 F42000
G1 Z4.04
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5289
M204 S6000
G3 X83.635 Y82.907 I-.866 J-9.114 E.03525
G3 X84.217 Y81.642 I1.721 J.026 E.02973
G1 X85.152 Y80.731 E.02707
G2 X85.45 Y78.455 I-1.751 J-1.387 E.05
G2 X84.131 Y77.09 I-7.624 J6.043 E.03944
G3 X83.833 Y74.814 I1.751 J-1.387 E.05
G3 X85.152 Y73.448 I7.624 J6.043 E.03944
G1 X85.365 Y73.097 E.00851
G1 X82.006 Y73.096 E.06966
G3 X81.424 Y74.358 I-1.72 J-.027 E.02969
G1 X80.49 Y75.269 E.02707
G2 X80.192 Y77.545 I1.751 J1.387 E.05
G2 X81.511 Y78.91 I7.623 J-6.042 E.03944
G3 X81.808 Y81.186 I-1.751 J1.387 E.05
G3 X80.49 Y82.552 I-7.623 J-6.042 E.03944
G1 X80.275 Y82.907 E.00859
G1 X76.697 Y82.907 E.07422
G3 X76.376 Y82.552 I-.086 J-.245 E.01261
G3 X76.934 Y81.642 I1.588 J.347 E.02257
G1 X77.869 Y80.731 E.02707
G2 X78.167 Y78.455 I-1.751 J-1.387 E.05
G2 X76.848 Y77.09 I-7.624 J6.043 E.03944
G3 X76.55 Y74.814 I1.751 J-1.387 E.05
G3 X77.869 Y73.448 I7.624 J6.043 E.03944
G1 X78.082 Y73.096 E.00854
G1 X79.779 Y73.096 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.082 Y73.096 E-.64486
G1 X77.925 Y73.355 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 34/73
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.44 I-1.104 J.513 P1  F42000
G1 X86.54 Y91.89 Z4.44
G1 Z4.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.56 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 34 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer34 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z4.16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5003
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.56 F42000
G1 X85.29 Y104.84 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5003
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.56 F42000
G1 X86.54 Y106.19 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5003
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.56 F42000
G1 X102.54 Y106.19 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5003
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.56 F42000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5003
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5003
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.831 Y87.507 Z4.56 F42000
G1 X91.107 Y84.607 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5003
M204 S6000
G1 X90.793 Y84.607 E.00649
G1 X90.793 Y74.703 E.20541
G1 X91.107 Y74.703 E.00649
G1 X91.107 Y84.547 E.20417
M204 S10000
G1 X91.531 Y85.031 F42000
G1 F5003
M204 S6000
G1 X90.369 Y85.031 E.02409
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X91.531 Y74.279 E.01659
G1 X91.531 Y84.971 E.22177
; WIPE_START
G1 F21000
G1 X90.369 Y85.031 E-.44197
G1 X90.369 Y84.194 E-.31803
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.04 Y85.44 Z4.56 F42000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X89.96 Y85.44 E.05937
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X91.94 Y73.87 E.01542
G1 X91.94 Y85.06 E.2157
G1 X93.04 Y85.06 E.0212
G1 X93.04 Y85.38 E.00617
; WIPE_START
M73 P57 R5
G1 F12000
M204 S6000
G1 X91.04 Y85.419 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.876 Y77.832 Z4.56 F42000
G1 X92.36 Y73.44 Z4.56
G1 Z4.16
G1 E.8 F1800
G1 F5003
M204 S5000
G1 X92.36 Y73.06 E.00732
G1 X93.04 Y73.06 E.01311
G1 X93.04 Y73.44 E.00732
G1 X92.42 Y73.44 E.01195
; WIPE_START
G1 F12000
M204 S6000
G1 X92.36 Y73.06 E-.14619
G1 X93.04 Y73.06 E-.2584
G1 X93.04 Y73.44 E-.1444
G1 X92.485 Y73.44 E-.211
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.552 Y79.147 Z4.56 F42000
G1 X103.14 Y85.44 Z4.56
G1 Z4.16
G1 E.8 F1800
G1 F5003
M204 S5000
G1 X102.46 Y85.44 E.01311
G1 X102.46 Y85.06 E.00732
G1 X103.14 Y85.06 E.01311
G1 X103.14 Y85.38 E.00617
; WIPE_START
G1 F12000
M204 S6000
G1 X102.46 Y85.44 E-.25941
G1 X102.46 Y85.06 E-.1444
G1 X103.14 Y85.06 E-.2584
G1 X103.14 Y85.317 E-.09778
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.393 Y83.797 Z4.56 F42000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5003
M204 S6000
G1 X104.393 Y73.893 E.20541
G1 X104.707 Y73.893 E.00649
G1 X104.707 Y83.797 E.20541
G1 X104.453 Y83.797 E.00525
M204 S10000
G1 X103.969 Y84.221 F42000
G1 F5003
M204 S6000
G1 X103.969 Y73.469 E.22301
G1 X105.131 Y73.469 E.02409
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X104.029 Y84.221 E.01535
M204 S250
G1 X103.56 Y84.63 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X103.56 Y73.44 E.2157
G1 X102.46 Y73.44 E.0212
G1 X102.46 Y73.06 E.00732
G1 X105.54 Y73.06 E.05937
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.62 Y84.63 E.01426
; OBJECT_ID: 88
; WIPE_START
G1 F12000
M204 S6000
G1 X103.609 Y82.63 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.981 Y82.891 Z4.56 F42000
G1 X85.308 Y83.256 Z4.56
G1 Z4.16
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5003
M204 S6000
G1 X76.692 Y83.256 E.1787
G3 X75.744 Y82.308 I-.014 J-.934 E.03102
G1 X75.744 Y73.692 E.1787
G3 X76.692 Y72.744 I.934 J-.014 E.03102
G1 X85.368 Y72.746 E.17996
G1 X85.385 Y72.747 E.00035
G3 X86.256 Y73.692 I-.062 J.931 E.02941
G1 X86.256 Y82.308 E.1787
G3 X85.368 Y83.255 I-.934 J.014 E.02978
M204 S10000
G1 X85.315 Y83.68 F42000
G1 F5003
M204 S6000
G1 X76.685 Y83.68 E.17899
G3 X75.32 Y82.315 I-.007 J-1.358 E.04456
G1 X75.32 Y73.685 E.17899
G3 X76.685 Y72.32 I1.358 J-.007 E.04456
G1 X85.375 Y72.322 E.18025
G3 X86.68 Y73.685 I-.052 J1.355 E.04329
G1 X86.68 Y82.315 E.17899
G3 X85.374 Y83.679 I-1.358 J.007 E.04331
M204 S250
G1 X85.32 Y84.089 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5003
M204 S5000
G1 X76.679 Y84.089 E.16657
G3 X74.911 Y82.321 I-.001 J-1.767 E.05354
G1 X74.911 Y73.679 E.16659
G3 X76.679 Y71.911 I1.767 J-.001 E.05354
G1 X85.382 Y71.913 E.16776
G3 X85.838 Y71.988 I-.057 J1.764 E.00894
G3 X87.089 Y73.679 I-.515 J1.69 E.04342
G1 X87.089 Y82.321 E.16659
G3 X85.38 Y84.088 I-1.767 J.001 E.0524
; WIPE_START
G1 F12000
M204 S6000
G1 X83.38 Y84.089 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.262 Y82.893 Z4.56 F42000
G1 Z4.16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5003
M204 S6000
G1 X83.565 Y82.893 E.0352
G3 X84.062 Y81.642 I1.483 J-.136 E.02897
G1 X85.099 Y80.731 E.02863
G2 X85.594 Y78.455 I-1.734 J-1.569 E.05057
G2 X84.184 Y77.09 I-4.808 J3.554 E.0409
G3 X83.689 Y74.814 I1.734 J-1.569 E.05057
G3 X85.099 Y73.448 I4.808 J3.554 E.0409
G1 X85.336 Y73.109 E.00858
G1 X82.076 Y73.109 E.06762
G3 X81.58 Y74.358 I-1.482 J.134 E.02893
G1 X80.542 Y75.269 E.02863
G2 X80.048 Y77.545 I1.734 J1.569 E.05057
G2 X81.458 Y78.91 I4.808 J-3.554 E.0409
G3 X81.952 Y81.186 I-1.734 J1.569 E.05057
G3 X80.542 Y82.552 I-4.808 J-3.554 E.0409
G1 X80.304 Y82.893 E.00863
G1 X76.704 Y82.893 E.07469
G3 X76.278 Y82.721 I-.014 J-.577 E.00978
G3 X76.779 Y81.642 I1.473 J.027 E.0254
G1 X77.816 Y80.731 E.02863
G2 X78.311 Y78.455 I-1.734 J-1.569 E.05057
G2 X76.901 Y77.09 I-4.808 J3.554 E.0409
G3 X76.406 Y74.814 I1.734 J-1.569 E.05057
G3 X77.816 Y73.448 I4.808 J3.554 E.0409
G1 X78.053 Y73.11 E.00856
G1 X79.75 Y73.109 E.0352
M106 S255
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.053 Y73.11 E-.64486
G1 X77.879 Y73.358 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M106 S201.45
M625
; layer num/total_layer_count: 35/73
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
M204 S10000
G17
G3 Z4.56 I-1.103 J.515 P1  F42000
G1 X86.54 Y91.89 Z4.56
G1 Z4.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.68 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M106 S201.45
M625
; object ids of layer 35 start: 66,77,88
M624 BwAAAAAAAAA=
M106 S255
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer35 end: 66,77,88
M106 S201.45
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
G1 X85.165 Y91.5
G1 Z4.28
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.68 F42000
G1 X85.29 Y104.84 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.68 F42000
G1 X86.54 Y106.19 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.68 F42000
G1 X102.54 Y106.19 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.68 F42000
G1 Z4.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M106 S201.45
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M106 S255
M204 S10000
G1 X96.026 Y87.206 Z4.68 F42000
G1 X92.207 Y84.607 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1560
M204 S6000
G1 X91.968 Y84.607 E.00496
G1 F4517.137
G1 X91.568 Y84.607 E.0083
G1 F9010.274
G1 X91.168 Y84.607 E.0083
G1 F14601.511
G1 X90.793 Y84.607 E.00776
G1 F21000
G1 X90.793 Y84.207 E.0083
G1 X90.793 Y75.103 E.18882
G1 X90.793 Y74.703 E.0083
G1 F14601.511
G1 X91.168 Y74.703 E.00776
G1 F9010.274
G1 X91.568 Y74.703 E.0083
G1 F4517.137
G1 X91.968 Y74.703 E.0083
G1 F1560
G1 X92.207 Y74.703 E.00496
G1 F600
G1 X92.207 Y84.547 E.20417
M106 S201.45
M106 S255
M204 S10000
G1 X92.631 Y85.031 F42000
G1 F21000
M204 S6000
M73 P58 R5
G1 X91.968 Y85.031 E.01376
G1 X90.369 Y85.031 E.03315
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y73.879 E.0085
G1 F19014.085
G1 X90.731 Y74.279 E.0083
G1 F12139.359
G1 X91.168 Y74.279 E.00906
G1 F6387.29
G1 X91.568 Y74.279 E.0083
G1 F2725.645
G1 X91.968 Y74.279 E.0083
G1 F600
G1 X92.35 Y74.279 E.00793
M106 S201.45
M106 S255
; FEATURE: Overhang wall

M204 S5000
G1 X92.631 Y74.279 E.00582
G1 X92.631 Y84.65 E.21512
M106 S201.45
M106 S255
; FEATURE: Inner wall
M204 S6000
G1 X92.631 Y84.971 E.00665
M106 S201.45
M106 S255
M204 S250
G1 X93.04 Y85.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X89.96 Y85.44 E.05937
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.47 E.0079
G1 X91.14 Y73.87 E.00771
G1 F6849.397
G1 X91.581 Y73.87 E.0085
G1 F2725.645
G1 X91.981 Y73.87 E.00771
G1 F600
G1 X92.35 Y73.87 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X92.36 Y73.85 E.00046
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X92.36 Y73.481 E.00711
M106 S201.45
M106 S255
G1 F2879.753
G1 X92.36 Y73.06 E.00812
G1 F5962.861
G1 X92.76 Y73.06 E.00771
G1 F5338.2
G1 X93.04 Y73.06 E.0054
G1 F2879.753
G1 X93.04 Y73.481 E.00812
G1 F600
G1 X93.04 Y73.85 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F1800
G1 X93.04 Y84.65 E.22402
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X93.04 Y85.019 E.00711
M106 S201.45
M106 S255
G1 F2450.884
G1 X93.04 Y85.38 E.00696
; WIPE_START
M204 S6000
G1 X91.04 Y85.419 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.68 I1.214 J.086 P1  F42000
G1 X91.747 Y75.41 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.520162
G1 F21000
M204 S6000
G1 X91.747 Y75.163 E.00598
G1 X91.253 Y75.163 E.01195
G1 X91.253 Y84.147 E.21718
G1 X91.747 Y84.147 E.01195
G1 X91.747 Y75.47 E.20975
; WIPE_START
G1 X91.747 Y77.47 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.68 I1.172 J.329 P1  F42000
G1 X92.7 Y74.075 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.296522
G1 F21000
M204 S6000
G1 X92.7 Y73.265 E.01072
; WIPE_START
G1 X92.7 Y74.075 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.68 I-.823 J.897 P1  F42000
G1 X103.293 Y83.797 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F600
M204 S6000
G1 X103.293 Y73.893 E.20541
M106 S201.45
M106 S255
G1 F1560
G1 X103.533 Y73.893 E.00496
G1 F4517.137
G1 X103.933 Y73.893 E.0083
G1 F9010.274
G1 X104.332 Y73.893 E.0083
G1 F14601.511
G1 X104.707 Y73.893 E.00776
G1 F21000
G1 X104.707 Y74.293 E.0083
G1 X104.707 Y83.397 E.18882
G1 X104.707 Y83.797 E.0083
G1 F14601.511
G1 X104.332 Y83.797 E.00776
G1 F9010.274
G1 X103.933 Y83.797 E.0083
G1 F4517.137
G1 X103.533 Y83.797 E.0083
G1 F1560
G1 X103.353 Y83.797 E.00371
M204 S250
G1 X103.15 Y84.221 F42000
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X102.869 Y84.221 E.00582
G1 X102.869 Y73.85 E.21512
M106 S201.45
M106 S255
; FEATURE: Inner wall
M204 S6000
G1 X102.869 Y73.469 E.0079
M106 S201.45
M106 S255
G1 F2725.645
G1 X103.269 Y73.469 E.0083
G1 F4962.765
G1 X103.533 Y73.469 E.00546
G1 F9635.329
G1 X103.933 Y73.469 E.0083
G1 F15843.892
G1 X104.333 Y73.469 E.0083
G1 F21000
G1 X104.733 Y73.469 E.0083
G1 X105.131 Y73.469 E.00826
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.621 E.0085
G1 F19014.085
G1 X104.769 Y84.221 E.0083
G1 F12139.359
G1 X104.333 Y84.221 E.00906
G1 F6387.29
G1 X103.933 Y84.221 E.0083
G1 F2725.645
G1 X103.533 Y84.221 E.0083
G1 F600
G1 X103.21 Y84.221 E.00669
M106 S201.45
M106 S255
; WIPE_START
G1 X102.869 Y84.221 E-.12949
G1 X102.869 Y82.562 E-.63051
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.68 I-1.212 J.114 P1  F42000
G1 X103.14 Y85.44 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F10155.762
M204 S5000
G1 X102.86 Y85.44 E.0054
G1 F6622.076
G1 X102.46 Y85.44 E.00771
G1 F2879.753
G1 X102.46 Y85.019 E.00812
G1 F600
G1 X102.46 Y84.65 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F1800
G1 X102.46 Y73.85 E.22402
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X102.46 Y73.481 E.00711
M106 S201.45
M106 S255
G1 F2879.753
G1 X102.46 Y73.06 E.00812
G1 F6622.076
G1 X102.86 Y73.06 E.00771
G1 F11900.399
G1 X103.26 Y73.06 E.00771
G1 F12000
G1 X103.66 Y73.06 E.00771
G1 X105.54 Y73.06 E.03624
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y85.03 E.0079
M73 P59 R5
G1 X104.36 Y84.63 E.00771
G1 F6849.397
G1 X103.919 Y84.63 E.0085
G1 F2725.645
G1 X103.519 Y84.63 E.00771
G1 F600
G1 X103.15 Y84.63 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X103.14 Y84.65 E.00046
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X103.14 Y85.019 E.00711
M106 S201.45
G1 F2450.884
G1 X103.14 Y85.38 E.00696
M204 S10000
G1 X102.8 Y85.235 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.296522
G1 F21000
M204 S6000
G1 X102.8 Y84.425 E.01072
; WIPE_START
G1 X102.8 Y85.235 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.68 I1.088 J.546 P1  F42000
G1 X103.753 Y83.337 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.520152
G1 F21000
M204 S6000
G1 X104.247 Y83.337 E.01195
G1 X104.247 Y74.353 E.21717
G1 X103.753 Y74.353 E.01195
G1 X103.753 Y83.277 E.21572
; OBJECT_ID: 88
; WIPE_START
G1 X103.753 Y81.277 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z4.68 I-.129 J-1.21 P1  F42000
G1 X85.301 Y83.242 Z4.68
G1 Z4.28
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X76.699 Y83.242 E.17842
G3 X75.758 Y82.301 I-.011 J-.931 E.03077
G1 X75.758 Y73.699 E.17842
G3 X76.699 Y72.758 I.927 J-.014 E.0308
G1 X85.363 Y72.76 E.17972
G1 X85.378 Y72.76 E.00031
G3 X86.242 Y73.699 I-.064 J.926 E.02918
G1 X86.242 Y82.301 E.17842
G3 X85.361 Y83.241 I-.931 J.011 E.02953
M204 S10000
G1 X85.308 Y83.667 F42000
G1 F21000
M204 S6000
G1 X76.692 Y83.667 E.17871
G3 X75.333 Y82.308 I-.002 J-1.356 E.04429
G1 X75.333 Y73.692 E.17871
G3 X76.692 Y72.333 I1.351 J-.007 E.04433
G1 X85.37 Y72.336 E.18001
G3 X86.667 Y73.692 I-.053 J1.348 E.04303
G1 X86.667 Y82.308 E.17871
G3 X85.368 Y83.665 I-1.356 J.002 E.04305
M204 S250
G1 X85.313 Y84.076 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.686 Y84.076 E.1663
G3 X74.924 Y82.315 I.006 J-1.767 E.05328
G1 X74.924 Y73.686 E.16633
G3 X76.685 Y71.924 I1.76 J-.001 E.05333
G1 X85.377 Y71.926 E.16754
G3 X87.076 Y73.686 I-.06 J1.758 E.05212
G1 X87.076 Y82.315 E.16633
G3 X85.373 Y84.075 I-1.767 J-.006 E.05215
; WIPE_START
M204 S6000
G1 X83.373 Y84.075 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.211 Y82.879 Z4.68 F42000
G1 Z4.28
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F24749.689
M204 S6000
G1 X83.514 Y82.879 E.0352
G3 X83.875 Y81.642 I1.13 J-.342 E.02829
G1 X85.05 Y80.731 E.03082
G2 X85.762 Y78.455 I-1.802 J-1.813 E.05146
G1 X85.408 Y78 E.01195
G1 X84.234 Y77.09 E.03082
G3 X83.522 Y74.814 I1.802 J-1.813 E.05146
G1 X83.875 Y74.358 E.01195
G1 X85.05 Y73.448 E.03082
G1 X85.31 Y73.123 E.00864
G1 X82.128 Y73.123 E.06599
G3 X81.767 Y74.358 I-1.13 J.34 E.02825
G1 X80.592 Y75.269 E.03082
G2 X79.88 Y77.545 I1.802 J1.813 E.05146
G1 X80.233 Y78 E.01195
G1 X81.408 Y78.91 E.03082
G3 X82.12 Y81.186 I-1.802 J1.813 E.05146
G1 X81.767 Y81.642 E.01195
G1 X80.592 Y82.552 E.03082
G1 X80.33 Y82.879 E.00869
G1 X76.71 Y82.879 E.07509
G3 X76.239 Y82.097 I-.034 J-.513 E.02335
G1 X76.592 Y81.642 E.01195
G1 X77.766 Y80.731 E.03082
G2 X78.478 Y78.455 I-1.802 J-1.813 E.05146
G1 X78.125 Y78 E.01195
G1 X76.951 Y77.09 E.03082
G3 X76.239 Y74.814 I1.802 J-1.813 E.05146
G1 X76.592 Y74.358 E.01195
G1 X77.766 Y73.448 E.03082
G1 X78.026 Y73.123 E.00863
G1 X79.723 Y73.123 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.026 Y73.123 E-.64486
G1 X77.837 Y73.36 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 36/73
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.68 I-1.102 J.517 P1  F42000
G1 X86.54 Y91.89 Z4.68
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 36 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer36 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z4.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5653
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.8 F42000
G1 X85.29 Y104.84 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5653
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.8 F42000
G1 X86.54 Y106.19 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5653
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.8 F42000
G1 X102.54 Y106.19 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5653
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5653
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5653
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X96.026 Y87.206 Z4.8 F42000
G1 X92.207 Y84.607 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P59 R4
G1 F5653
M204 S6000
G1 X90.793 Y84.607 E.02931
G1 X90.793 Y74.703 E.20541
G1 X92.207 Y74.703 E.02931
G1 X92.207 Y84.547 E.20417
M204 S10000
G1 X92.631 Y85.031 F42000
G1 F5653
M204 S6000
G1 X90.369 Y85.031 E.04691
G1 X90.369 Y73.469 E.23982
G1 X90.731 Y73.469 E.0075
G1 X90.731 Y74.279 E.0168
G1 X92.631 Y74.279 E.03941
G1 X92.631 Y84.971 E.22177
M204 S250
G1 X93.04 Y85.44 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X89.96 Y85.44 E.05937
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
G1 X92.36 Y73.87 E.02352
G1 X92.36 Y73.06 E.01561
G1 X93.04 Y73.06 E.01311
G1 X93.04 Y85.38 E.23748
; WIPE_START
G1 F12000
M204 S6000
G1 X91.04 Y85.419 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.8 I1.214 J.086 P1  F42000
G1 X91.747 Y75.41 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.520162
G1 F5653
M204 S6000
G1 X91.747 Y75.163 E.00598
G1 X91.253 Y75.163 E.01195
G1 X91.253 Y84.147 E.21718
G1 X91.747 Y84.147 E.01195
G1 X91.747 Y75.47 E.20975
; WIPE_START
G1 F21000
G1 X91.747 Y77.47 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.8 I1.172 J.329 P1  F42000
G1 X92.7 Y74.075 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.296522
G1 F5653
M204 S6000
G1 X92.7 Y73.265 E.01072
; WIPE_START
G1 F21000
G1 X92.7 Y74.075 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.8 I-.823 J.897 P1  F42000
G1 X103.293 Y83.797 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5653
M204 S6000
M73 P60 R4
G1 X103.293 Y73.893 E.20541
G1 X104.707 Y73.893 E.02931
G1 X104.707 Y83.797 E.20541
G1 X103.353 Y83.797 E.02807
M204 S10000
G1 X103.14 Y84.221 F42000
G1 F5653
M204 S6000
G1 X102.869 Y84.221 E.00562
G1 X102.869 Y73.469 E.22301
G1 X105.131 Y73.469 E.04691
G1 X105.131 Y85.031 E.23982
G1 X104.769 Y85.031 E.0075
G1 X104.769 Y84.221 E.0168
G1 X103.2 Y84.221 E.03255
; WIPE_START
G1 F21000
G1 X102.869 Y84.221 E-.12569
G1 X102.869 Y82.552 E-.63431
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.8 I-1.212 J.114 P1  F42000
G1 X103.14 Y85.44 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X102.46 Y85.44 E.01311
G1 X102.46 Y73.06 E.23863
G1 X105.54 Y73.06 E.05937
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.14 Y84.63 E.02352
G1 X103.14 Y85.38 E.01446
M204 S10000
G1 X102.8 Y85.235 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.296522
G1 F5653
M204 S6000
G1 X102.8 Y84.425 E.01072
; WIPE_START
G1 F21000
G1 X102.8 Y85.235 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.8 I1.088 J.546 P1  F42000
G1 X103.753 Y83.337 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.520152
G1 F5653
M204 S6000
G1 X104.247 Y83.337 E.01195
G1 X104.247 Y74.353 E.21717
G1 X103.753 Y74.353 E.01195
G1 X103.753 Y83.277 E.21572
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X103.753 Y81.277 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z4.8 I-.128 J-1.21 P1  F42000
G1 X85.294 Y83.229 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5653
M204 S6000
G1 X76.706 Y83.229 E.17814
G3 X75.771 Y82.294 I-.011 J-.924 E.03056
G1 X75.771 Y73.706 E.17814
G3 X75.911 Y73.204 I.934 J-.01 E.01095
G3 X76.706 Y72.771 I.785 J.495 E.01961
G1 X85.359 Y72.773 E.17949
G1 X85.371 Y72.774 E.00025
G3 X86.229 Y73.706 I-.062 J.918 E.02898
G1 X86.229 Y82.294 E.17813
G3 X86.089 Y82.796 I-.934 J.01 E.01095
G3 X85.354 Y83.228 I-.781 J-.488 E.01839
M204 S10000
G1 X85.301 Y83.653 F42000
G1 F5653
M204 S6000
G1 X76.699 Y83.653 E.17843
G3 X75.347 Y82.301 I-.002 J-1.35 E.04407
G1 X75.347 Y73.699 E.17843
G3 X76.699 Y72.347 I1.344 J-.007 E.04412
G1 X85.366 Y72.349 E.17978
G3 X86.653 Y73.699 I-.061 J1.347 E.04272
G1 X86.653 Y82.301 E.17843
G3 X85.361 Y83.652 I-1.35 J.002 E.04283
M204 S250
G1 X85.306 Y84.062 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5653
M204 S5000
G1 X76.692 Y84.062 E.16603
G3 X74.938 Y82.308 I.006 J-1.76 E.05308
G1 X74.938 Y73.692 E.16607
G3 X76.692 Y71.938 I1.754 J-.001 E.05313
G1 X85.373 Y71.94 E.16732
G3 X87.062 Y73.692 I-.07 J1.758 E.05182
G1 X87.062 Y82.308 E.16607
G3 X85.366 Y84.061 I-1.76 J-.006 E.05196
; WIPE_START
G1 F12000
M204 S6000
G1 X83.366 Y84.061 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.109 Y82.866 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5653
M204 S6000
G1 X83.412 Y82.866 E.0352
G3 X83.628 Y81.642 I.995 J-.456 E.02742
G2 X85.417 Y80.276 I-3.019 J-5.808 E.04691
G2 X85.865 Y78.308 I-2.274 J-1.553 E.04286
G1 X85.655 Y78 E.00773
G3 X83.866 Y76.634 I3.018 J-5.807 E.04691
G3 X83.318 Y74.814 I2.384 J-1.71 E.04017
G1 X83.628 Y74.358 E.01142
G2 X85.286 Y73.136 I-3.141 J-5.996 E.04289
G1 X82.23 Y73.136 E.0634
G3 X82.013 Y74.358 I-.995 J.454 E.02738
G2 X80.225 Y75.724 I3.019 J5.808 E.04691
G2 X79.677 Y77.545 I2.384 J1.71 E.04017
G1 X79.987 Y78 E.01142
G3 X81.775 Y79.366 I-3.019 J5.807 E.04691
G3 X82.323 Y81.186 I-2.384 J1.71 E.04017
G1 X82.013 Y81.642 E.01142
G2 X80.354 Y82.866 I3.138 J5.991 E.04295
G1 X76.717 Y82.866 E.07543
G3 X76.345 Y81.642 I.077 J-.692 E.03366
G2 X78.134 Y80.276 I-3.019 J-5.807 E.04691
G2 X78.682 Y78.455 I-2.384 J-1.71 E.04017
G1 X78.372 Y78 E.01142
G3 X76.583 Y76.634 I3.019 J-5.807 E.04691
G3 X76.134 Y74.668 I2.279 J-1.555 E.04282
G1 X76.345 Y74.358 E.00778
G2 X78.003 Y73.137 I-3.141 J-5.997 E.04288
G1 X79.7 Y73.136 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X78.003 Y73.137 E-.64486
G1 X77.799 Y73.361 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 37/73
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.8 I-1.101 J.519 P1  F42000
G1 X86.54 Y91.89 Z4.8
G1 Z4.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.92 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 37 start: 66,77,88
M624 BwAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer37 end: 66,77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z4.52
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6188
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z4.92 F42000
G1 X85.29 Y104.84 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6188
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z4.92 F42000
G1 X86.54 Y106.19 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6188
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z4.92 F42000
G1 X102.54 Y106.19 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6188
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z4.92 F42000
G1 Z4.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6188
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6188
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 66
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 66
M624 AQAAAAAAAAA=
M204 S10000
G1 X95.942 Y87.332 Z4.92 F42000
G1 X93.04 Y85.44 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X89.96 Y85.44 E.05937
G1 X89.96 Y73.06 E.23863
G1 X91.14 Y73.06 E.02275
G1 X91.14 Y73.87 E.01561
M73 P61 R4
G1 X92.36 Y73.87 E.02352
G1 X92.36 Y73.06 E.01561
G1 X93.04 Y73.06 E.01311
G1 X93.04 Y85.38 E.23748
; WIPE_START
G1 F12000
M204 S6000
G1 X91.04 Y85.419 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.92 I1.204 J.176 P1  F42000
G1 X92.7 Y74.075 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.296522
G1 F6188
M204 S6000
G1 X92.7 Y73.265 E.01072
; WIPE_START
G1 F21000
G1 X92.7 Y74.075 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X91.75 Y74.087 Z4.92 F42000
G1 Z4.52
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6188
M204 S2000
G1 X92.823 Y75.16 E.02924
G1 X92.823 Y75.717
G1 X91.193 Y74.087 E.04444
G1 X90.923 Y73.817
G1 X90.383 Y73.277 E.01473
G1 X90.177 Y73.628
G1 X92.823 Y76.275 E.07214
G1 X92.823 Y76.832
G1 X90.177 Y74.186 E.07214
G1 X90.177 Y74.743
G1 X92.823 Y77.39 E.07214
G1 X92.823 Y77.947
G1 X90.177 Y75.301 E.07214
G1 X90.177 Y75.858
G1 X92.823 Y78.505 E.07214
G1 X92.823 Y79.062
G1 X90.177 Y76.416 E.07214
G1 X90.177 Y76.974
G1 X92.823 Y79.62 E.07214
G1 X92.823 Y80.177
G1 X90.177 Y77.531 E.07214
G1 X90.177 Y78.089
G1 X92.823 Y80.735 E.07214
G1 X92.823 Y81.292
G1 X90.177 Y78.646 E.07214
G1 X90.177 Y79.204
G1 X92.823 Y81.85 E.07214
G1 X92.823 Y82.408
G1 X90.177 Y79.761 E.07214
G1 X90.177 Y80.319
G1 X92.823 Y82.965 E.07214
G1 X92.823 Y83.523
G1 X90.177 Y80.876 E.07214
G1 X90.177 Y81.434
G1 X92.823 Y84.08 E.07214
G1 X92.823 Y84.638
G1 X90.177 Y81.991 E.07214
G1 X90.177 Y82.549
G1 X92.823 Y85.195 E.07214
G1 X92.294 Y85.223
G1 X90.177 Y83.106 E.0577
G1 X90.177 Y83.664
G1 X91.736 Y85.223 E.0425
G1 X91.178 Y85.223
G1 X90.177 Y84.222 E.0273
G1 X90.177 Y84.779
G1 X90.621 Y85.223 E.01211
; WIPE_START
G1 F12000
M204 S6000
G1 X90.177 Y84.779 E-.23867
G1 X90.177 Y84.222 E-.21187
G1 X90.753 Y84.797 E-.30947
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X92.317 Y77.327 Z4.92 F42000
G1 X92.843 Y74.818 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.142013
G1 F6188
M204 S6000
G1 X92.092 Y74.067 E.00604
; WIPE_START
G1 F21000
G1 X92.843 Y74.818 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.92 I-.874 J.847 P1  F42000
G1 X103.14 Y85.44 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X102.46 Y85.44 E.01311
G1 X102.46 Y73.06 E.23863
G1 X105.54 Y73.06 E.05937
G1 X105.54 Y85.44 E.23863
G1 X104.36 Y85.44 E.02275
G1 X104.36 Y84.63 E.01561
G1 X103.14 Y84.63 E.02352
G1 X103.14 Y85.38 E.01446
M204 S10000
G1 X102.8 Y85.235 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.296522
G1 F6188
M204 S6000
G1 X102.8 Y84.425 E.01072
; WIPE_START
G1 F21000
G1 X102.8 Y85.235 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.92 I1.199 J.208 P1  F42000
G1 X104.879 Y73.277 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6188
M204 S2000
G1 X105.323 Y73.721 E.01211
G1 X105.323 Y74.279
G1 X104.321 Y73.277 E.02731
G1 X103.764 Y73.277
G1 X105.323 Y74.836 E.04251
G1 X105.323 Y75.394
G1 X103.206 Y73.277 E.05771
G1 X102.677 Y73.305
G1 X105.323 Y75.951 E.07214
G1 X105.323 Y76.509
G1 X102.677 Y73.862 E.07214
G1 X102.677 Y74.42
G1 X105.323 Y77.066 E.07214
G1 X105.323 Y77.624
G1 X102.677 Y74.977 E.07214
G1 X102.677 Y75.535
G1 X105.323 Y78.181 E.07214
G1 X105.323 Y78.739
G1 X102.677 Y76.093 E.07214
G1 X102.677 Y76.65
G1 X105.323 Y79.296 E.07214
G1 X105.323 Y79.854
G1 X102.677 Y77.208 E.07214
G1 X102.677 Y77.765
G1 X105.323 Y80.412 E.07214
G1 X105.323 Y80.969
G1 X102.677 Y78.323 E.07214
G1 X102.677 Y78.88
G1 X105.323 Y81.527 E.07214
G1 X105.323 Y82.084
G1 X102.677 Y79.438 E.07214
G1 X102.677 Y79.995
G1 X105.323 Y82.642 E.07214
G1 X105.323 Y83.199
G1 X102.677 Y80.553 E.07214
G1 X102.677 Y81.11
G1 X105.323 Y83.757 E.07214
G1 X105.323 Y84.314
G1 X102.677 Y81.668 E.07214
G1 X102.677 Y82.226
G1 X105.323 Y84.872 E.07214
G1 X105.117 Y85.223
G1 X104.577 Y84.683 E.01472
G1 X104.307 Y84.413
G1 X102.677 Y82.783 E.04444
G1 X102.677 Y83.341
G1 X103.749 Y84.413 E.02924
M204 S10000
G1 X103.408 Y84.433 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.141897
G1 F6188
M204 S6000
G1 X102.657 Y83.682 E.00603
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X103.408 Y84.433 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 66
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z4.92 I.082 J-1.214 P1  F42000
G1 X85.287 Y83.215 Z4.92
G1 Z4.52
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6188
M204 S6000
G1 X76.713 Y83.215 E.17786
G3 X75.785 Y82.287 I-.011 J-.917 E.03033
G1 X75.785 Y73.713 E.17786
G3 X76.713 Y72.785 I.914 J-.014 E.03036
G1 X85.355 Y72.787 E.17926
G1 X85.364 Y72.787 E.00019
G3 X86.215 Y73.713 I-.064 J.913 E.02875
G1 X86.215 Y82.288 E.17786
G3 X85.347 Y83.214 I-.917 J.011 E.02908
M204 S10000
G1 X85.294 Y83.64 F42000
G1 F6188
M204 S6000
G1 X76.706 Y83.64 E.17815
G3 X75.361 Y82.294 I-.002 J-1.343 E.04385
G1 X75.361 Y73.706 E.17815
G3 X76.706 Y72.361 I1.338 J-.007 E.04389
G1 X85.362 Y72.363 E.17955
G3 X86.64 Y73.706 I-.058 J1.335 E.04249
G1 X86.64 Y82.294 E.17815
G3 X85.354 Y83.638 I-1.343 J.002 E.0426
M204 S250
G1 X85.298 Y84.049 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6188
M204 S5000
G1 X76.699 Y84.049 E.16576
G3 X74.951 Y82.301 I-.001 J-1.747 E.05293
G1 X74.951 Y73.699 E.16581
G3 X76.699 Y71.951 I1.754 J.006 E.05287
G1 X85.368 Y71.953 E.1671
M73 P62 R4
G3 X87.049 Y73.699 I-.072 J1.751 E.05157
G1 X87.049 Y82.301 E.16581
G3 X85.358 Y84.048 I-1.754 J-.006 E.05177
; WIPE_START
G1 F12000
M204 S6000
G1 X83.358 Y84.048 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.99 Y82.852 Z4.92 F42000
G1 Z4.52
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6188
M204 S6000
G1 X83.293 Y82.852 E.0352
G3 X83.054 Y82.097 I2.307 J-1.144 E.0165
G1 X83.202 Y81.642 E.00993
G2 X84.957 Y80.731 I-4.005 J-9.865 E.04106
G2 X85.852 Y79.541 I-1.869 J-2.337 E.03121
G1 X85.851 Y77.893 E.03418
G3 X83.855 Y76.634 I2.083 J-5.516 E.04928
G3 X83.054 Y74.814 I4.673 J-3.14 E.04147
G1 X83.202 Y74.358 E.00993
G2 X85.266 Y73.15 I-2.254 J-6.215 E.04988
G1 X82.349 Y73.15 E.06049
G3 X82.587 Y73.903 I-2.301 J1.14 E.01645
G1 X82.439 Y74.358 E.00993
G2 X80.685 Y75.269 I4.005 J9.864 E.04106
G2 X79.413 Y77.545 I2.75 J3.03 E.05504
G1 X79.561 Y78 E.00993
G3 X81.315 Y78.91 I-4.006 J9.865 E.04106
G3 X82.587 Y81.186 I-2.75 J3.03 E.05504
G1 X82.439 Y81.642 E.00993
G2 X80.374 Y82.852 I2.251 J6.208 E.04994
G1 X76.724 Y82.852 E.07571
G3 X76.148 Y82.271 I.002 J-.578 E.01887
G1 X76.148 Y81.535 E.01525
G2 X78.145 Y80.276 I-2.083 J-5.519 E.04931
G2 X78.946 Y78.455 I-4.673 J-3.141 E.04147
G1 X78.798 Y78 E.00993
G3 X77.043 Y77.09 I4.005 J-9.865 E.04106
G3 X76.148 Y75.897 I1.869 J-2.337 E.03126
G1 X76.148 Y74.252 E.03413
G2 X77.982 Y73.15 I-2.173 J-5.698 E.04463
G1 X79.679 Y73.15 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X77.982 Y73.15 E-.64486
G1 X77.764 Y73.36 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 38/73
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.92 I-1.1 J.521 P1  F42000
G1 X86.54 Y91.89 Z4.92
G1 Z4.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3081
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.04 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 38 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer38 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z4.64
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3081
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z5.04 F42000
G1 X85.29 Y104.84 Z5.04
G1 Z4.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3081
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3081
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z5.04 F42000
G1 X86.54 Y106.19 Z5.04
G1 Z4.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3081
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3081
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z5.04 F42000
G1 X102.54 Y106.19 Z5.04
G1 Z4.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3081
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3081
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z5.04 F42000
G1 Z4.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3081
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3081
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3081
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3081
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.472 Y88.161 Z5.04 F42000
G1 X85.28 Y83.202 Z5.04
G1 Z4.64
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3081
M204 S6000
G1 X76.719 Y83.202 E.17758
G3 X75.798 Y82.28 I-.01 J-.911 E.0301
G1 X75.798 Y73.719 E.17758
G3 X76.719 Y72.798 I.906 J-.015 E.03014
G1 X85.349 Y72.801 E.17901
G1 X85.356 Y72.801 E.00014
G3 X86.202 Y73.72 I-.061 J.905 E.02857
G1 X86.202 Y82.281 E.17758
G3 X85.34 Y83.2 I-.911 J.01 E.02886
M204 S10000
G1 X85.288 Y83.626 F42000
G1 F3081
M204 S6000
G1 X76.712 Y83.626 E.17787
G3 X75.374 Y82.288 I-.002 J-1.337 E.04362
G1 X75.374 Y73.712 E.17787
G3 X76.712 Y72.374 I1.33 J-.008 E.04368
G1 X85.357 Y72.376 E.17931
G3 X86.626 Y73.712 I-.066 J1.334 E.04219
G1 X86.626 Y82.288 E.17787
G3 X85.347 Y83.625 I-1.337 J.002 E.04238
M204 S250
G1 X85.291 Y84.035 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3081
M204 S5000
G1 X76.706 Y84.035 E.16549
G3 X74.965 Y82.294 I.006 J-1.747 E.05266
G1 X74.965 Y73.706 E.16555
G3 X76.706 Y71.965 I1.74 J-.001 E.05273
G1 X85.364 Y71.967 E.16689
G3 X87.035 Y73.706 I-.075 J1.745 E.05132
G1 X87.035 Y82.294 E.16555
G3 X85.351 Y84.034 I-1.747 J-.006 E.05157
; WIPE_START
G1 F12000
M204 S6000
G1 X83.351 Y84.034 E-.76
; WIPE_END
M73 P63 R4
G1 E-.04 F1800
M204 S10000
G1 X84.834 Y82.839 Z5.04 F42000
G1 Z4.64
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3081
M204 S6000
G1 X83.137 Y82.839 E.0352
G1 X82.821 Y82.266 E.01358
G1 X82.366 Y82.009 E.01084
G2 X80.545 Y82.682 I.535 J4.245 E.04062
G1 X80.384 Y82.839 E.00466
G1 X76.73 Y82.839 E.07579
G3 X76.161 Y82.264 I.003 J-.572 E.01864
G1 X76.161 Y81.256 E.02091
G1 X76.448 Y81.224 E.00599
G2 X78.724 Y79.45 I-.655 J-3.187 E.06201
G1 X79.179 Y78.624 E.01956
G1 X79.634 Y78.367 E.01084
G3 X81.455 Y79.041 I-.535 J4.246 E.04062
G3 X82.821 Y81.018 I-4.651 J4.673 E.05012
G1 X83.276 Y81.275 E.01084
G2 X85.097 Y80.601 I-.535 J-4.246 E.04062
G2 X85.838 Y79.713 I-1.565 J-2.059 E.02421
G1 X85.838 Y77.614 E.04353
G1 X85.552 Y77.582 E.00596
G3 X83.276 Y75.809 I.655 J-3.187 E.06201
G1 X82.821 Y74.982 E.01956
G1 X82.366 Y74.726 E.01084
G2 X80.545 Y75.399 I.535 J4.246 E.04062
G2 X79.179 Y77.376 I4.652 J4.673 E.05012
G1 X78.724 Y77.633 E.01084
G3 X76.903 Y76.96 I.535 J-4.246 E.04062
G3 X76.161 Y76.07 I1.568 J-2.062 E.02424
G1 X76.161 Y73.973 E.0435
G1 X76.448 Y73.941 E.00599
G2 X77.972 Y73.164 I-.697 J-3.25 E.03589
G1 X82.506 Y73.163 E.09405
G1 X82.821 Y73.734 E.01352
G1 X83.276 Y73.991 E.01084
G2 X85.097 Y73.318 I-.535 J-4.245 E.04062
G3 X85.819 Y73.565 I.313 J.263 E.0204
G3 X85.837 Y74.511 I-2.882 J.527 E.01971
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X85.819 Y73.565 E-.35945
G1 X85.678 Y73.321 E-.10734
G1 X85.504 Y73.204 E-.07955
G1 X85.255 Y73.163 E-.09573
G1 X85.097 Y73.318 E-.08413
G1 X85.022 Y73.366 E-.0338
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 39/73
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.04 I-1.213 J.099 P1  F42000
G1 X86.54 Y91.89 Z5.04
G1 Z4.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.16 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 39 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer39 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z4.76
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3064
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z5.16 F42000
G1 X85.29 Y104.84 Z5.16
G1 Z4.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3064
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z5.16 F42000
G1 X86.54 Y106.19 Z5.16
G1 Z4.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3064
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z5.16 F42000
G1 X102.54 Y106.19 Z5.16
G1 Z4.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3064
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z5.16 F42000
G1 Z4.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3064
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3064
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.474 Y88.157 Z5.16 F42000
G1 X85.274 Y83.188 Z5.16
G1 Z4.76
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3064
M204 S6000
G1 X76.726 Y83.188 E.1773
G3 X75.812 Y82.274 I-.011 J-.904 E.02989
G1 X75.812 Y73.726 E.1773
G3 X76.726 Y72.812 I.904 J-.011 E.02989
G1 X85.348 Y72.814 E.17884
G3 X86.188 Y73.726 I-.06 J.898 E.02837
G1 X86.188 Y82.274 E.1773
G3 X85.334 Y83.187 I-.904 J.011 E.02865
M204 S10000
G1 X85.281 Y83.612 F42000
G1 F3064
M204 S6000
G1 X76.719 Y83.612 E.17759
G3 X75.388 Y82.281 I-.002 J-1.329 E.04341
G1 X75.388 Y73.719 E.17759
G3 X76.719 Y72.388 I1.329 J-.002 E.04341
G1 X85.352 Y72.39 E.17907
G3 X86.612 Y73.719 I-.069 J1.327 E.04192
G1 X86.612 Y82.281 E.17759
G3 X85.341 Y83.611 I-1.329 J.002 E.04217
M204 S250
G1 X85.284 Y84.022 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3064
M204 S5000
G1 X76.713 Y84.022 E.16522
G3 X74.978 Y82.287 I.006 J-1.74 E.05246
G1 X74.978 Y73.713 E.16529
G3 X76.713 Y71.978 I1.74 J.006 E.05246
G1 X85.359 Y71.981 E.16667
G3 X87.022 Y73.713 I-.077 J1.738 E.05107
G1 X87.022 Y82.287 E.16529
G3 X85.344 Y84.021 I-1.74 J-.006 E.05138
; WIPE_START
G1 F12000
M204 S6000
G1 X83.344 Y84.021 E-.76
; WIPE_END
M73 P64 R4
G1 E-.04 F1800
M204 S10000
G1 X84.773 Y82.825 Z5.16 F42000
G1 Z4.76
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3064
M204 S6000
G1 X83.076 Y82.825 E.0352
G2 X82.366 Y82.24 I-2.428 J2.222 E.01916
G1 X81.91 Y82.198 E.00948
G2 X80.387 Y82.825 I.317 J2.933 E.03464
G1 X76.737 Y82.825 E.0757
G3 X76.175 Y82.257 I0 J-.563 E.01845
G1 X76.175 Y81.06 E.02482
G1 X76.448 Y81.085 E.0057
G2 X78.269 Y80.203 I-.356 J-3.056 E.04276
G1 X79.179 Y78.934 E.03241
G1 X79.634 Y78.598 E.01173
G1 X80.09 Y78.556 E.00948
G3 X81.91 Y79.438 I-.356 J3.055 E.04276
G1 X82.821 Y80.708 E.03241
G1 X83.276 Y81.044 E.01173
G1 X83.731 Y81.085 E.00948
G2 X85.552 Y80.203 I-.356 J-3.056 E.04276
G1 X85.825 Y79.823 E.00971
G1 X85.824 Y77.419 E.04987
G1 X85.552 Y77.444 E.00567
G3 X83.731 Y76.562 I.356 J-3.055 E.04276
G1 X82.821 Y75.292 E.03241
G1 X82.366 Y74.957 E.01173
G1 X81.91 Y74.915 E.00948
G2 X80.09 Y75.797 I.356 J3.056 E.04276
G1 X79.179 Y77.067 E.03241
G1 X78.724 Y77.402 E.01173
G1 X78.269 Y77.444 E.00948
G3 X76.175 Y76.18 I.25 J-2.782 E.05251
G1 X76.175 Y73.777 E.04985
G1 X76.448 Y73.802 E.0057
G2 X77.972 Y73.175 I-.317 J-2.933 E.03463
G1 X82.642 Y73.176 E.09689
G2 X83.731 Y73.802 I1.048 J-.563 E.02744
G2 X85.306 Y73.177 I-.366 J-3.218 E.03557
G3 X85.823 Y73.68 I-.079 J.598 E.01603
G1 X85.823 Y74.535 E.01774
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X85.823 Y73.68 E-.32491
G1 X85.657 Y73.325 E-.14917
G1 X85.306 Y73.177 E-.14458
G1 X84.984 Y73.363 E-.14134
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 40/73
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.16 I-1.213 J.102 P1  F42000
G1 X86.54 Y91.89 Z5.16
G1 Z4.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3052
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.28 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 40 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer40 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z4.88
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3052
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z5.28 F42000
G1 X85.29 Y104.84 Z5.28
G1 Z4.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3052
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3052
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z5.28 F42000
G1 X86.54 Y106.19 Z5.28
G1 Z4.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3052
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3052
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z5.28 F42000
G1 X102.54 Y106.19 Z5.28
G1 Z4.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3052
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3052
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z5.28 F42000
G1 Z4.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3052
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3052
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3052
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3052
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.475 Y88.154 Z5.28 F42000
G1 X85.267 Y83.175 Z5.28
G1 Z4.88
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3052
M204 S6000
G1 X76.733 Y83.175 E.17702
G3 X75.825 Y82.267 I-.011 J-.897 E.02967
G1 X75.825 Y73.733 E.17702
G3 X76.733 Y72.825 I.897 J-.011 E.02967
G1 X85.317 Y72.828 E.17805
G3 X86.175 Y73.733 I-.032 J.89 E.02866
G1 X86.175 Y82.267 E.17702
G3 X85.327 Y83.173 I-.897 J.011 E.02843
M204 S10000
G1 X85.274 Y83.599 F42000
G1 F3052
M204 S6000
G1 X76.726 Y83.599 E.17731
G3 X75.401 Y82.274 I-.002 J-1.322 E.04319
G1 X75.401 Y73.726 E.17731
G3 X76.726 Y72.401 I1.322 J-.002 E.04319
G1 X85.333 Y72.403 E.17854
G3 X86.599 Y73.726 I-.049 J1.314 E.04199
G1 X86.599 Y82.274 E.17731
G3 X85.334 Y83.598 I-1.322 J.002 E.04195
M204 S250
G1 X85.277 Y84.008 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3052
M204 S5000
G1 X76.719 Y84.008 E.16495
G3 X74.992 Y82.281 I.006 J-1.733 E.05226
G1 X74.992 Y73.719 E.16503
G3 X76.719 Y71.992 I1.733 J.006 E.05226
G1 X85.35 Y71.994 E.16636
G3 X87.008 Y73.719 I-.066 J1.723 E.05098
G1 X87.008 Y82.281 E.16503
G3 X85.337 Y84.007 I-1.733 J-.006 E.05118
; WIPE_START
G1 F12000
M204 S6000
G1 X83.337 Y84.007 E-.76
; WIPE_END
M73 P65 R4
G1 E-.04 F1800
M204 S10000
G1 X84.55 Y82.812 Z5.28 F42000
G1 Z4.88
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3052
M204 S6000
G1 X82.853 Y82.812 E.0352
G3 X82.366 Y82.424 I5.581 J-7.512 E.01291
G2 X80.382 Y82.812 I-.589 J2.257 E.04335
G1 X76.744 Y82.812 E.07546
G3 X76.188 Y82.25 I.002 J-.558 E.01822
G1 X76.188 Y80.904 E.02793
G2 X78.269 Y80.252 I.382 J-2.428 E.04686
G1 X79.179 Y79.147 E.0297
G3 X80.545 Y78.712 I1.063 J.975 E.03111
G3 X81.91 Y79.39 I-.608 J2.937 E.03198
G1 X82.821 Y80.495 E.0297
G2 X84.186 Y80.93 I1.063 J-.975 E.03111
G2 X85.811 Y79.937 I-.443 J-2.551 E.04045
G1 X85.81 Y77.263 E.05547
G3 X83.731 Y76.61 I-.38 J-2.429 E.04683
G1 X82.821 Y75.505 E.0297
G2 X81.455 Y75.07 I-1.063 J.975 E.03111
G2 X80.09 Y75.748 I.608 J2.937 E.03198
G1 X79.179 Y76.854 E.0297
G3 X77.814 Y77.289 I-1.063 J-.975 E.03111
G3 X76.188 Y76.295 I.443 J-2.551 E.04047
G3 X76.194 Y73.653 I21.574 J-1.275 E.05484
G1 X76.201 Y73.624 E.00062
G2 X77.976 Y73.189 I.371 J-2.326 E.03894
G1 X82.803 Y73.19 E.10012
G2 X84.642 Y73.524 I1.14 J-1.043 E.04164
G3 X85.297 Y73.191 I14.769 J28.188 E.01525
G3 X85.809 Y73.699 I-.02 J.532 E.01646
G1 X85.81 Y74.562 E.01789
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X85.809 Y73.699 E-.32781
G1 X85.656 Y73.344 E-.14704
G1 X85.297 Y73.191 E-.14833
G1 X84.976 Y73.354 E-.13682
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 41/73
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.28 I-1.213 J.102 P1  F42000
G1 X86.54 Y91.89 Z5.28
G1 Z5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3042
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 41 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer41 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3042
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z5.4 F42000
G1 X85.29 Y104.84 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3042
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3042
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z5.4 F42000
G1 X86.54 Y106.19 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3042
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3042
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z5.4 F42000
G1 X102.54 Y106.19 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3042
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3042
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z5.4 F42000
G1 Z5
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3042
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3042
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3042
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3042
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.477 Y88.151 Z5.4 F42000
G1 X85.26 Y83.161 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3042
M204 S6000
G1 X76.74 Y83.161 E.17674
G3 X75.839 Y82.26 I-.011 J-.89 E.02945
G1 X75.839 Y73.74 E.17674
G3 X76.739 Y72.839 I.89 J-.011 E.02945
G1 X85.312 Y72.841 E.17781
G3 X86.161 Y73.74 I-.034 J.883 E.0284
G1 X86.161 Y82.26 E.17674
G3 X85.32 Y83.16 I-.89 J.011 E.02821
M204 S10000
G1 X85.267 Y83.585 F42000
G1 F3042
M204 S6000
G1 X76.733 Y83.585 E.17703
G3 X75.415 Y82.267 I-.002 J-1.316 E.04297
G1 X75.415 Y73.733 E.17703
G3 X76.733 Y72.415 I1.316 J-.002 E.04297
G1 X85.329 Y72.417 E.1783
G3 X86.585 Y73.733 I-.051 J1.307 E.04173
G1 X86.585 Y82.267 E.17703
G3 X85.327 Y83.584 I-1.316 J.002 E.04173
M204 S250
G1 X85.27 Y83.995 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3042
M204 S5000
G1 X76.726 Y83.995 E.16468
G3 X75.005 Y82.274 I.006 J-1.727 E.05205
G1 X75.005 Y73.726 E.16477
G3 X76.726 Y72.005 I1.727 J.006 E.05205
G1 X85.345 Y72.008 E.16614
G3 X86.995 Y73.726 I-.068 J1.717 E.05073
G1 X86.995 Y82.274 E.16477
G3 X85.33 Y83.994 I-1.727 J-.006 E.05098
; WIPE_START
G1 F12000
M204 S6000
G1 X83.33 Y83.994 E-.76
; WIPE_END
M73 P66 R4
G1 E-.04 F1800
M204 S10000
G1 X84.326 Y82.798 Z5.4 F42000
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3042
M204 S6000
G1 X82.629 Y82.798 E.0352
G2 X81 Y82.505 I-1.082 J1.34 E.0358
G2 X80.368 Y82.798 I.387 J1.659 E.01456
G1 X76.751 Y82.798 E.07503
G3 X76.202 Y82.244 I.012 J-.562 E.01791
G1 X76.202 Y80.774 E.03049
G2 X78.269 Y80.303 I.581 J-2.222 E.04571
G3 X79.634 Y78.938 I5.825 J4.464 E.04016
G3 X81.91 Y79.339 I.797 J2.136 E.05027
G2 X83.276 Y80.703 I5.824 J-4.462 E.04016
G2 X85.798 Y80.037 I.795 J-2.096 E.05774
G1 X85.797 Y77.132 E.06024
G3 X83.731 Y76.661 I-.579 J-2.223 E.04568
G2 X82.366 Y75.297 I-5.825 J4.463 E.04016
G2 X80.09 Y75.697 I-.797 J2.136 E.05027
G3 X78.724 Y77.062 I-5.825 J-4.463 E.04016
G3 X76.202 Y76.394 I-.795 J-2.097 E.05776
G3 X76.207 Y73.66 I22.273 J-1.322 E.05675
G3 X76.448 Y73.573 I.127 J-.025 E.00763
G2 X77.99 Y73.202 I.272 J-2.26 E.0336
G1 X83.015 Y73.204 E.10424
G2 X84.642 Y73.495 I1.08 J-1.342 E.03575
G3 X85.377 Y73.213 I1.315 J2.328 E.01639
G3 X85.796 Y73.707 I-.138 J.542 E.01432
G1 X85.796 Y74.6 E.01852
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X85.796 Y73.707 E-.33937
G1 X85.644 Y73.356 E-.14522
G1 X85.377 Y73.213 E-.11516
G1 X85.27 Y73.204 E-.04074
G1 X84.985 Y73.336 E-.1195
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 42/73
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.4 I-1.213 J.102 P1  F42000
G1 X86.54 Y91.89 Z5.4
G1 Z5.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.52 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 42 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer42 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z5.12
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3036
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z5.52 F42000
G1 X85.29 Y104.84 Z5.52
G1 Z5.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3036
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z5.52 F42000
G1 X86.54 Y106.19 Z5.52
G1 Z5.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3036
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z5.52 F42000
G1 X102.54 Y106.19 Z5.52
G1 Z5.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3036
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z5.52 F42000
G1 Z5.12
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3036
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3036
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.479 Y88.147 Z5.52 F42000
G1 X85.254 Y83.148 Z5.52
G1 Z5.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3036
M204 S6000
G1 X76.746 Y83.148 E.17646
G3 X75.852 Y82.253 I-.011 J-.883 E.02924
G1 X75.852 Y73.746 E.17645
G3 X76.746 Y72.852 I.883 J-.011 E.02923
G1 X85.29 Y72.854 E.17721
G3 X86.148 Y73.746 I-.02 J.878 E.0285
G1 X86.148 Y82.254 E.17646
G3 X85.314 Y83.146 I-.883 J.011 E.02799
M204 S10000
G1 X85.26 Y83.572 F42000
G1 F3036
M204 S6000
G1 X76.74 Y83.572 E.17674
G3 X75.428 Y82.26 I-.003 J-1.309 E.04276
G1 X75.428 Y73.74 E.17674
G3 X76.74 Y72.428 I1.309 J-.003 E.04275
G1 X85.314 Y72.43 E.17785
G3 X86.572 Y73.74 I-.044 J1.301 E.04168
G1 X86.572 Y82.26 E.17674
G3 X85.32 Y83.571 I-1.309 J.003 E.04151
M204 S250
G1 X85.263 Y83.981 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3036
M204 S5000
G1 X76.733 Y83.981 E.16442
G3 X75.019 Y82.267 I.006 J-1.72 E.05185
G1 X75.019 Y73.733 E.1645
G3 X76.733 Y72.019 I1.72 J.006 E.05185
G1 X85.337 Y72.021 E.16585
G3 X86.981 Y73.733 I-.067 J1.71 E.05055
G1 X86.981 Y82.267 E.1645
G3 X85.323 Y83.98 I-1.72 J-.006 E.05078
; WIPE_START
G1 F12000
M204 S6000
G1 X83.323 Y83.98 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.144 Y82.785 Z5.52 F42000
M73 P67 R4
G1 Z5.12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3036
M204 S6000
G1 X82.447 Y82.785 E.0352
G2 X80.34 Y82.785 I-1.053 J1.629 E.0462
G1 X76.758 Y82.785 E.07431
G3 X76.215 Y82.237 I.012 J-.555 E.01769
G1 X76.215 Y80.662 E.03266
G2 X78.724 Y79.956 I.734 J-2.203 E.0574
G3 X80.09 Y78.881 I2.596 J1.894 E.0365
G3 X82.366 Y79.686 I.409 J2.464 E.05226
G2 X83.731 Y80.76 I2.595 J-1.894 E.0365
G2 X85.784 Y80.152 I.416 J-2.367 E.04603
G1 X85.783 Y77.021 E.06495
G3 X83.276 Y76.314 I-.732 J-2.204 E.05736
G2 X81.91 Y75.24 I-2.596 J1.894 E.0365
G2 X79.634 Y76.044 I-.409 J2.464 E.05226
G3 X78.269 Y77.119 I-2.595 J-1.894 E.0365
G3 X76.215 Y76.51 I-.416 J-2.367 E.04605
G1 X76.215 Y73.758 E.05709
G3 X76.322 Y73.424 I.74 J.053 E.00734
G2 X78.018 Y73.215 I.603 J-2.094 E.03642
G1 X83.196 Y73.216 E.10739
G2 X85.295 Y73.219 I1.052 J-1.623 E.04603
G3 X85.782 Y73.713 I-.029 J.517 E.01579
G1 X85.783 Y74.649 E.01941
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X85.782 Y73.713 E-.35555
G1 X85.632 Y73.367 E-.14327
G1 X85.295 Y73.219 E-.14014
G1 X84.998 Y73.335 E-.12104
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 43/73
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.52 I-1.213 J.101 P1  F42000
G1 X86.54 Y91.89 Z5.52
G1 Z5.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3030
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.64 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 43 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer43 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z5.24
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3030
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z5.64 F42000
G1 X85.29 Y104.84 Z5.64
G1 Z5.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3030
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3030
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z5.64 F42000
G1 X86.54 Y106.19 Z5.64
G1 Z5.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3030
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3030
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z5.64 F42000
G1 X102.54 Y106.19 Z5.64
G1 Z5.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3030
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3030
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z5.64 F42000
G1 Z5.24
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3030
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3030
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3030
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3030
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.48 Y88.144 Z5.64 F42000
G1 X85.247 Y83.134 Z5.64
G1 Z5.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3030
M204 S6000
G1 X76.753 Y83.134 E.17618
G3 X75.866 Y82.247 I-.011 J-.876 E.02902
G1 X75.866 Y73.753 E.17618
G3 X76.753 Y72.866 I.876 J-.011 E.02901
G1 X85.285 Y72.867 E.17697
G3 X86.134 Y73.753 I-.022 J.871 E.02824
G1 X86.134 Y82.247 E.17618
G3 X85.307 Y83.133 I-.876 J.011 E.02777
M204 S10000
G1 X85.254 Y83.558 F42000
G1 F3030
M204 S6000
G1 X76.746 Y83.558 E.17646
G3 X75.442 Y82.254 I-.003 J-1.302 E.04253
G1 X75.442 Y73.746 E.17646
G3 X76.746 Y72.442 I1.302 J-.003 E.04253
M73 P67 R3
G1 X85.309 Y72.443 E.17761
G3 X86.558 Y73.746 I-.046 J1.295 E.04142
G1 X86.558 Y82.254 E.17646
G3 X85.314 Y83.557 I-1.302 J.003 E.04129
M204 S250
G1 X85.256 Y83.968 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3030
M204 S5000
G1 X76.74 Y83.968 E.16415
G3 X75.032 Y82.26 I.006 J-1.713 E.05165
G1 X75.032 Y73.74 E.16424
G3 X76.74 Y72.032 I1.713 J.006 E.05165
G1 X85.332 Y72.035 E.16563
G3 X86.968 Y73.74 I-.069 J1.703 E.05031
G1 X86.968 Y82.26 E.16424
G3 X85.316 Y83.967 I-1.713 J-.006 E.05058
; WIPE_START
G1 F12000
M204 S6000
G1 X83.316 Y83.967 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.931 Y82.771 Z5.64 F42000
G1 Z5.24
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P68 R3
G1 F3030
M204 S6000
G1 X82.234 Y82.771 E.0352
G2 X80.292 Y82.771 I-.971 J1.856 E.0419
G1 X76.765 Y82.771 E.07316
G3 X76.229 Y82.23 I.012 J-.548 E.01747
G1 X76.229 Y80.564 E.03455
G2 X78.724 Y80.057 I.883 J-2.047 E.05622
G3 X80.09 Y78.968 I3.222 J2.639 E.0365
G3 X82.366 Y79.585 I.597 J2.304 E.05117
G2 X83.731 Y80.674 I3.222 J-2.639 E.0365
G2 X85.771 Y80.243 I.596 J-2.221 E.04487
G1 X85.77 Y76.923 E.06885
G3 X83.276 Y76.415 I-.881 J-2.048 E.05618
G2 X81.91 Y75.326 I-3.222 J2.639 E.0365
G2 X79.634 Y75.943 I-.597 J2.305 E.05117
G3 X78.269 Y77.032 I-3.222 J-2.638 E.0365
G3 X76.229 Y76.601 I-.596 J-2.221 E.04489
G1 X76.229 Y73.765 E.05883
G3 X76.396 Y73.365 I.534 J-.011 E.00926
G2 X78.066 Y73.229 I.669 J-2.111 E.03564
G1 X83.409 Y73.23 E.11082
G2 X85.359 Y73.24 I.986 J-1.924 E.04197
G3 X85.769 Y73.709 I-.179 J.57 E.01358
G1 X85.769 Y74.711 E.02078
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X85.769 Y73.709 E-.38071
G1 X85.612 Y73.371 E-.14157
G1 X85.359 Y73.24 E-.10802
G1 X85.033 Y73.34 E-.1297
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 44/73
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.64 I-1.213 J.099 P1  F42000
G1 X86.54 Y91.89 Z5.64
G1 Z5.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3266
M204 S5000
G1 X84.96 Y91.89 E.03046
G1 X84.96 Y91.11 E.01504
G1 X86.54 Y91.11 E.03046
G1 X86.54 Y91.83 E.01388
; WIPE_START
G1 F12000
M204 S6000
G1 X84.96 Y91.89 E-.60084
G1 X84.96 Y91.471 E-.15916
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.76 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 44 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer44 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X85.165 Y91.5
G1 Z5.36
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3266
M204 S6000
G1 X86.335 Y91.5 E.02122
; WIPE_START
G1 F21000
G1 X85.165 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.236 Y99.132 Z5.76 F42000
G1 X85.29 Y104.84 Z5.76
G1 Z5.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3266
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3266
M204 S6000
G1 X84.9 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.975 Y102.221 Z5.76 F42000
G1 X86.54 Y106.19 Z5.76
G1 Z5.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3266
M204 S5000
G1 X84.96 Y106.19 E.03046
G1 X84.96 Y105.41 E.01504
G1 X86.54 Y105.41 E.03046
G1 X86.54 Y106.13 E.01388
M204 S10000
G1 X86.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3266
M204 S6000
G1 X85.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X86.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X93.966 Y105.984 Z5.76 F42000
G1 X102.54 Y106.19 Z5.76
G1 Z5.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3266
M204 S5000
G1 X100.96 Y106.19 E.03046
G1 X100.96 Y105.41 E.01504
G1 X102.54 Y105.41 E.03046
G1 X102.54 Y106.13 E.01388
M204 S10000
G1 X102.335 Y105.8 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3266
M204 S6000
G1 X101.165 Y105.8 E.02122
; WIPE_START
G1 F21000
G1 X102.335 Y105.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.99 Y104.84 Z5.76 F42000
G1 Z5.36
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3266
M204 S5000
G1 X102.21 Y104.84 E.01504
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.78 E.23748
M204 S10000
G1 X102.6 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3266
M204 S6000
G1 X102.6 Y92.665 E.217
M204 S250
G1 X102.54 Y91.89 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3266
M204 S5000
G1 X100.96 Y91.89 E.03046
G1 X100.96 Y91.11 E.01504
G1 X102.54 Y91.11 E.03046
G1 X102.54 Y91.83 E.01388
M204 S10000
G1 X102.335 Y91.5 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3266
M204 S6000
G1 X101.165 Y91.5 E.02122
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X102.335 Y91.5 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X95.482 Y88.141 Z5.76 F42000
G1 X85.24 Y83.121 Z5.76
G1 Z5.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3266
M204 S6000
G1 X76.76 Y83.121 E.17589
G3 X75.879 Y82.24 I-.011 J-.869 E.0288
G1 X75.879 Y73.76 E.17589
G3 X76.76 Y72.879 I.869 J-.011 E.0288
G1 X85.28 Y72.881 E.17672
G3 X86.121 Y73.76 I-.024 J.864 E.02799
G1 X86.121 Y82.24 E.17589
G3 X85.3 Y83.119 I-.869 J.011 E.02755
M204 S10000
G1 X85.247 Y83.545 F42000
G1 F3266
M204 S6000
G1 X76.753 Y83.545 E.17619
G3 X75.455 Y82.247 I-.003 J-1.295 E.04231
G1 X75.455 Y73.753 E.17619
G3 X76.753 Y72.455 I1.295 J-.003 E.04231
G1 X85.304 Y72.457 E.17738
G3 X86.545 Y73.753 I-.048 J1.288 E.04116
G1 X86.545 Y82.247 E.17619
G3 X85.307 Y83.544 I-1.295 J.003 E.04107
M204 S250
G1 X85.249 Y83.954 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3266
M204 S5000
G1 X76.746 Y83.954 E.16389
G3 X75.046 Y82.254 I.006 J-1.706 E.05144
G1 X75.046 Y73.746 E.16398
G3 X76.746 Y72.046 I1.706 J.006 E.05144
G1 X85.328 Y72.048 E.16541
G3 X86.954 Y73.746 I-.072 J1.697 E.05006
G1 X86.954 Y82.254 E.16398
G3 X85.309 Y83.953 I-1.706 J-.006 E.05038
; WIPE_START
G1 F12000
M204 S6000
G1 X83.309 Y83.953 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.622 Y82.742 Z5.76 F42000
G1 Z5.36
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
;_EXTRUDE_SET_SPEED
M204 S6000
G1 X76.828 Y82.742 E.09631
; Slow Down End
M204 S10000
G1 X76.242 Y82.064 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3266
M204 S6000
G1 X76.242 Y81.312 E.0156
G1 X76.637 Y81.172 E.00868
G1 X76.637 Y80.646 E.01093
G2 X79.179 Y79.718 I.582 J-2.354 E.05956
G3 X82.366 Y79.484 I1.705 J1.405 E.07408
G2 X83.731 Y80.596 I4.183 J-3.745 E.03667
M73 P69 R3
G2 X85.757 Y80.333 I.759 J-2.095 E.04402
G1 X85.757 Y79.979 E.00735
G1 X85.655 Y80.118 E.00358
G1 X85.363 Y80.023 E.00638
G1 X85.362 Y77.004 E.0626
G3 X82.821 Y76.077 I-.58 J-2.354 E.05953
G2 X79.634 Y75.843 I-1.705 J1.405 E.07408
G3 X78.269 Y76.954 I-4.183 J-3.745 E.03667
G3 X76.637 Y76.911 I-.765 J-1.963 E.03478
G1 X76.637 Y75.567 E.02787
G1 X76.294 Y75.5 E.00724
G1 X76.242 Y75.627 E.00284
G3 X76.248 Y73.683 I15.905 J-.928 E.04034
G3 X76.486 Y73.322 I.488 J.063 E.00928
G2 X77.134 Y73.442 I.589 J-1.376 E.01379
G1 X77.055 Y73.637 E.00436
G1 X78.541 Y73.637 E.03084
M204 S10000
G1 X77.618 Y73.258 F42000
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1800;_EXTRUDE_SET_SPEED
M204 S6000
G1 X85.251 Y73.259 E.12689
G1 X85.482 Y73.325 E.00399
G1 X85.676 Y73.517 E.00454
G1 X85.74 Y73.731 E.00371
G1 X85.741 Y79.209 E.09106
; Slow Down End
M204 S10000
G1 X76.258 Y80.905 F42000
G1 F3266
M204 S6000
G1 X76.258 Y80.219 E.0114
M204 S10000
G1 X76.258 Y77.046 F42000
G1 F3266
M204 S6000
G1 X76.258 Y76.648 E.00661
M106 S255
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F16800
G1 X76.258 Y77.046 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M106 S201.45
M625
; layer num/total_layer_count: 45/73
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
M204 S10000
G17
G3 Z5.76 I-.884 J.836 P1  F42000
G1 X102.539 Y104.84 Z5.76
G1 Z5.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X102.21 Y104.84 E.00635
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.599 Y104.84 E.00753
; WIPE_START
M204 S6000
G1 X102.21 Y104.84 E-.14795
G1 X102.21 Y103.229 E-.61205
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5.88 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M106 S201.45
M625
; object ids of layer 45 start: 77,88
M624 BgAAAAAAAAA=
M106 S255
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer45 end: 77,88
M106 S201.45
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
G1 X102.6 Y104.635
G1 Z5.48
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z5.88 F42000
G1 X85.29 Y104.84 Z5.88
G1 Z5.48
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F21000
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M106 S201.45
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M106 S255
M204 S10000
G1 X85.12 Y87.035 Z5.88 F42000
G1 X85.233 Y83.107 Z5.88
G1 Z5.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F21000
M204 S6000
G1 X76.767 Y83.107 E.17562
G3 X75.893 Y82.233 I-.01 J-.864 E.02857
G1 X75.893 Y73.767 E.17562
G3 X76.767 Y72.893 I.864 J-.01 E.02856
G1 X85.275 Y72.894 E.17649
G3 X86.107 Y73.767 I-.026 J.857 E.02772
G1 X86.107 Y82.233 E.17562
G3 X85.293 Y83.106 I-.864 J.01 E.02731
M204 S10000
G1 X85.24 Y83.531 F42000
G1 F21000
M204 S6000
G1 X76.76 Y83.531 E.17591
G3 X75.469 Y82.24 I-.002 J-1.289 E.04209
G1 X75.469 Y73.76 E.17591
G3 X76.76 Y72.469 I1.289 J-.002 E.04208
G1 X85.3 Y72.471 E.17714
G3 X86.531 Y73.76 I-.05 J1.281 E.0409
G1 X86.531 Y82.24 E.17591
G3 X85.3 Y83.53 I-1.289 J.002 E.04084
M204 S250
G1 X85.242 Y83.941 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X76.753 Y83.941 E.16363
G3 X75.059 Y82.247 I.006 J-1.7 E.05123
G1 X75.059 Y73.753 E.16372
G3 X76.753 Y72.059 I1.7 J.006 E.05123
G1 X85.323 Y72.062 E.1652
G3 X86.941 Y73.753 I-.074 J1.689 E.04981
G1 X86.941 Y82.247 E.16372
G3 X85.302 Y83.939 I-1.7 J-.006 E.05017
; WIPE_START
M204 S6000
G1 X83.302 Y83.94 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.744 Y82.121 Z5.88 F42000
G1 Z5.48
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F24749.689
M204 S6000
G1 X85.744 Y80.425 E.0352
G3 X85.282 Y80.631 I-.638 J-.806 E.01061
G1 X84.811 Y81.277 E.01658
G3 X83.918 Y81.257 I-.404 J-1.949 E.01868
M204 S10000
G1 X85.275 Y80.242 F42000
; FEATURE: Bridge
; LINE_WIDTH: 0.41024
; LAYER_HEIGHT: 0.4
G1 F1800
M204 S6000
G1 X85.731 Y79.126 E.06493
G1 X85.73 Y77.91 E.06552
G1 X84.528 Y80.853 E.1712
G3 X84.039 Y80.835 I-.206 J-1.074 E.02663
G1 X85.73 Y76.693 E.24093
G1 X85.73 Y75.477 E.06552
G1 X83.576 Y80.751 E.30683
G1 X83.385 Y80.717 E.01041
G1 X82.563 Y82.731 E.1172
G1 X82.27 Y82.731 E.01577
G1 X85.729 Y74.26 E.4928
G1 X85.729 Y73.725 E.02884
G2 X85.581 Y73.406 I-.626 J.098 E.01916
G1 X81.773 Y82.731 E.54246
G1 X81.275 Y82.731 E.02677
G1 X85.139 Y73.27 E.5504
G1 X84.642 Y73.27 E.02677
G1 X80.778 Y82.731 E.55041
G1 X80.281 Y82.731 E.02677
G1 X84.145 Y73.27 E.55041
G1 X83.648 Y73.27 E.02677
G1 X79.784 Y82.731 E.55042
G1 X79.287 Y82.731 E.02677
G1 X83.151 Y73.27 E.55042
G1 X82.654 Y73.27 E.02677
G1 X78.79 Y82.731 E.55043
G1 X78.293 Y82.731 E.02677
G1 X82.157 Y73.269 E.55043
G1 X81.66 Y73.269 E.02677
G1 X77.796 Y82.731 E.55044
M73 P70 R3
G1 X77.298 Y82.731 E.02677
G1 X81.162 Y73.269 E.55044
G1 X80.665 Y73.269 E.02677
G1 X76.856 Y82.598 E.54266
G1 X77.256 Y80.49 E.11555
G1 X77.214 Y80.505 E.00242
G1 X80.168 Y73.269 E.4209
G1 X79.671 Y73.269 E.02677
G1 X76.632 Y80.71 E.43287
G1 X76.269 Y80.839 E.02079
G1 X76.269 Y80.384 E.02451
G1 X79.174 Y73.269 E.41389
G1 X78.677 Y73.269 E.02677
G1 X77.064 Y77.219 E.22976
G1 X76.619 Y77.09 E.02493
G1 X78.18 Y73.269 E.22227
G1 X77.683 Y73.269 E.02677
G1 X76.098 Y77.149 E.22575
M106 S201.45
M204 S10000
G1 X76.5 Y74.995 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F24749.689
M204 S6000
G1 X77.142 Y73.424 E.0352
G3 X76.564 Y73.296 I.855 J-5.201 E.01227
G2 X76.256 Y73.778 I.234 J.49 E.01251
G1 X76.256 Y74.842 E.02207
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X76.256 Y73.778 E-.40441
G1 X76.324 Y73.503 E-.10745
G1 X76.564 Y73.296 E-.12074
G1 X76.892 Y73.368 E-.1274
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 46/73
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.88 I-.943 J.769 P1  F42000
G1 X102.539 Y104.84 Z5.88
G1 Z5.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3854
M204 S5000
G1 X102.21 Y104.84 E.00634
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.599 Y104.84 E.00754
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14779
G1 X102.21 Y103.229 E-.61221
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 46 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer46 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z5.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3854
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6 F42000
G1 X85.29 Y104.84 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3854
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3854
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X85.115 Y87.035 Z6 F42000
G1 X85.226 Y83.094 Z6
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3854
M204 S6000
G1 X76.774 Y83.094 E.17533
G3 X75.906 Y82.226 I-.011 J-.856 E.02835
G1 X75.906 Y73.774 E.17533
G3 X76.773 Y72.906 I.856 J-.011 E.02835
G1 X85.27 Y72.908 E.17624
G3 X86.094 Y73.773 I-.027 J.851 E.02747
G1 X86.094 Y82.226 E.17534
G3 X85.286 Y83.092 I-.856 J.011 E.02711
M204 S10000
G1 X85.234 Y83.518 F42000
G1 F3854
M204 S6000
G1 X76.767 Y83.518 E.17563
G3 X75.482 Y82.234 I-.003 J-1.282 E.04187
G1 X75.482 Y73.767 E.17563
G3 X76.766 Y72.482 I1.282 J-.003 E.04187
G1 X85.295 Y72.484 E.1769
G3 X86.518 Y73.766 I-.052 J1.274 E.04064
G1 X86.518 Y82.233 E.17563
G3 X85.293 Y83.517 I-1.282 J.003 E.04063
M204 S250
G1 X85.235 Y83.927 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3854
M204 S5000
G1 X76.76 Y83.927 E.16337
G3 X75.073 Y82.24 I.006 J-1.693 E.05103
G1 X75.073 Y73.76 E.16346
G3 X76.76 Y72.073 I1.693 J.006 E.05103
G1 X85.318 Y72.076 E.16497
G3 X86.927 Y73.76 I-.076 J1.683 E.04957
G1 X86.927 Y82.24 E.16346
G3 X85.295 Y83.926 I-1.693 J-.006 E.04997
; WIPE_START
G1 F12000
M204 S6000
G1 X83.295 Y83.926 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.731 Y82.216 Z6 F42000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3854
M204 S6000
G2 X85.73 Y80.519 I-13.035 J-.845 E.03522
G3 X83.512 Y80.299 I-.935 J-1.859 E.04879
G1 X79.622 Y82.731 E.09516
G1 X79.971 Y82.731 E.00725
G3 X81.688 Y82.731 I.858 J1.956 E.03664
G1 X83.385 Y82.731 E.0352
M204 S10000
G1 X83.741 Y79.883 F42000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.425842
M73 P71 R3
G1 F3854
M204 S6000
G1 X85.745 Y77.879 E.05543
G1 X85.744 Y77.579 E.00588
G1 X85.581 Y77.477 E.00377
G1 X82.79 Y80.268 E.07722
G1 X81.281 Y81.211 E.0348
G1 X85.233 Y77.259 E.10932
G1 X84.885 Y77.042 E.00803
G1 X79.773 Y82.154 E.14142
G1 X79.082 Y82.585 E.01593
G1 X79.021 Y82.746 E.00336
G1 X78.615 Y82.746 E.00794
G1 X84.537 Y76.824 E.16382
G1 X84.188 Y76.606 E.00803
G1 X78.049 Y82.746 E.16984
G1 X77.988 Y82.746 E.00119
G1 X77.988 Y82.241 E.00988
G1 X83.84 Y76.389 E.16189
G1 X83.492 Y76.171 E.00803
G1 X77.988 Y81.675 E.15226
G1 X77.988 Y81.109 E.01107
G1 X83.144 Y75.953 E.14263
G1 X82.796 Y75.736 E.00803
G1 X77.988 Y80.543 E.133
G1 X77.988 Y79.978 E.01107
G1 X82.448 Y75.518 E.12336
G1 X82.099 Y75.301 E.00803
G1 X77.988 Y79.412 E.11373
G1 X77.988 Y78.846 E.01107
G1 X81.751 Y75.083 E.1041
G1 X81.403 Y74.865 E.00803
G1 X77.988 Y78.28 E.09447
G1 X77.988 Y77.714 E.01107
G1 X81.055 Y74.648 E.08484
G1 X80.707 Y74.43 E.00803
G1 X77.988 Y77.148 E.0752
G1 X77.988 Y76.583 E.01107
G1 X80.358 Y74.212 E.06557
G1 X80.01 Y73.995 E.00803
G1 X77.988 Y76.017 E.05594
G1 X77.988 Y75.451 E.01107
G1 X79.662 Y73.777 E.04631
G1 X79.314 Y73.559 E.00803
G1 X77.988 Y74.885 E.03667
G1 X77.988 Y74.319 E.01107
G1 X79.03 Y73.278 E.02881
G1 X79.021 Y73.255 E.00049
G1 X78.487 Y73.255 E.01044
G1 X77.811 Y73.931 E.01871
M204 S10000
G1 X76.269 Y74.761 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3854
M204 S6000
G3 X76.298 Y73.6 I3.267 J-.501 E.02421
G3 X76.903 Y73.368 I.389 J.109 E.01562
G2 X77.579 Y73.447 I.524 J-1.552 E.01421
G1 X77.579 Y77.051 E.07476
G3 X76.269 Y76.878 I-.444 J-1.682 E.0281
G1 X76.269 Y80.329 E.07158
G2 X77.579 Y80.73 I1.153 J-1.426 E.02911
G1 X77.579 Y82.427 E.0352
M204 S10000
G1 X83.961 Y75.982 F42000
G1 F3854
M204 S6000
G1 X85.4 Y76.881 E.0352
G2 X85.729 Y76.688 I-.25 J-.804 E.00798
G1 X85.728 Y73.742 E.06111
G2 X85.513 Y73.353 I-.578 J.066 E.00947
G3 X83.957 Y73.27 I-.661 J-2.238 E.03295
G1 X82.26 Y73.27 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X83.957 Y73.27 E-.64486
G1 X84.249 Y73.348 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 47/73
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6 I-1.052 J.611 P1  F42000
G1 X102.538 Y104.84 Z6
G1 Z5.72
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3843
M204 S5000
G1 X102.21 Y104.84 E.00633
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.598 Y104.84 E.00755
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14762
G1 X102.21 Y103.228 E-.61238
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.12 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 47 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer47 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z5.72
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3843
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.12 F42000
G1 X85.29 Y104.84 Z6.12
G1 Z5.72
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3843
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3843
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X85.106 Y87.035 Z6.12 F42000
G1 X85.213 Y83.08 Z6.12
G1 Z5.72
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3843
M204 S6000
G1 X76.78 Y83.08 E.17492
G3 X75.92 Y82.213 I-.011 J-.849 E.02828
G1 X75.92 Y73.78 E.17492
G3 X76.78 Y72.92 I.849 J-.011 E.02813
G1 X85.265 Y72.921 E.176
G3 X86.08 Y73.78 I-.03 J.844 E.02721
G1 X86.08 Y82.22 E.17506
G3 X85.273 Y83.079 I-.849 J.011 E.02703
M204 S10000
G1 X85.223 Y83.504 F42000
G1 F3843
M204 S6000
G1 X76.773 Y83.504 E.17526
G3 X75.496 Y82.223 I-.003 J-1.275 E.04174
G1 X75.496 Y73.773 E.17526
G3 X76.773 Y72.496 I1.275 J-.003 E.04165
G1 X85.29 Y72.498 E.17666
G3 X86.504 Y73.773 I-.054 J1.267 E.04037
G1 X86.504 Y82.227 E.17534
G3 X85.283 Y83.503 I-1.275 J.003 E.04049
M204 S250
G1 X85.229 Y83.914 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3843
M204 S5000
G1 X76.767 Y83.914 E.16311
G3 X75.086 Y82.232 I.006 J-1.686 E.05085
G1 X75.086 Y73.767 E.16318
G3 X76.767 Y72.086 I1.686 J.005 E.05083
G1 X85.314 Y72.089 E.16475
G3 X86.914 Y73.767 I-.078 J1.676 E.04932
G1 X86.914 Y82.233 E.1632
G3 X85.289 Y83.912 I-1.686 J-.005 E.04976
; WIPE_START
G1 F12000
M204 S6000
G1 X83.289 Y83.913 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.007 Y79.365 Z6.12 F42000
G1 Z5.72
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3843
M204 S6000
G1 X83.568 Y80.265 E.0352
G2 X85.717 Y80.62 I1.374 J-1.637 E.0474
G3 X85.705 Y82.33 I-9.216 J.794 E.03553
G3 X85.197 Y82.717 I-.509 J-.142 E.01424
G1 X81.576 Y82.717 E.0751
G2 X79.812 Y82.717 I-.882 J1.901 E.03776
G1 X79.643 Y82.717 E.00351
G1 X80.19 Y82.375 E.01338
M204 S10000
M73 P72 R3
G1 X76.283 Y74.691 F42000
G1 F3843
M204 S6000
G3 X76.32 Y73.588 I2.669 J-.462 E.02306
G3 X76.903 Y73.344 I.406 J.151 E.01471
G2 X77.579 Y73.473 I.649 J-1.556 E.01437
G1 X77.579 Y77.044 E.07407
G3 X76.283 Y76.978 I-.565 J-1.648 E.02758
G1 X76.283 Y80.263 E.06815
G2 X77.579 Y80.757 I1.28 J-1.414 E.02944
G1 X77.579 Y82.454 E.0352
M204 S10000
G1 X78.663 Y82.91 F42000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.425282
G1 F3843
M204 S6000
G1 X77.988 Y82.234 E.01865
G1 X77.988 Y81.669 E.01104
G1 X79.033 Y82.714 E.02886
G1 X79.082 Y82.585 E.00269
G1 X79.32 Y82.436 E.00548
G1 X77.988 Y81.104 E.0368
G1 X77.988 Y80.539 E.01104
G1 X79.668 Y82.219 E.0464
G1 X80.016 Y82.002 E.00801
G1 X77.988 Y79.974 E.05601
G1 X77.988 Y79.409 E.01104
G1 X80.363 Y81.785 E.06562
G1 X80.711 Y81.567 E.00801
G1 X77.988 Y78.844 E.07522
G1 X77.988 Y78.279 E.01104
G1 X81.059 Y81.35 E.08483
G1 X81.407 Y81.133 E.00801
G1 X77.988 Y77.714 E.09443
G1 X77.988 Y77.149 E.01104
G1 X81.754 Y80.915 E.10404
G1 X82.102 Y80.698 E.00801
G1 X77.988 Y76.584 E.11365
G1 X77.988 Y76.019 E.01104
G1 X82.45 Y80.481 E.12325
G1 X82.797 Y80.263 E.00801
G1 X77.988 Y75.454 E.13286
G1 X77.988 Y74.889 E.01104
G1 X83.145 Y80.046 E.14246
G1 X83.493 Y79.829 E.00801
G1 X77.988 Y74.324 E.15207
G1 X77.988 Y73.759 E.01104
G1 X83.841 Y79.611 E.16167
G1 X84.188 Y79.394 E.00801
G1 X78.062 Y73.268 E.16924
G1 X78.627 Y73.268 E.01104
G1 X84.536 Y79.177 E.16323
G1 X84.884 Y78.96 E.00801
G1 X79.767 Y73.842 E.14136
G1 X81.274 Y74.784 E.03471
G1 X85.231 Y78.742 E.10934
G1 X85.579 Y78.525 E.00801
G1 X82.78 Y75.726 E.07731
G1 X84.287 Y76.668 E.03471
G1 X85.909 Y78.289 E.04478
M204 S10000
G1 X83.918 Y75.955 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3843
M204 S6000
G1 X85.357 Y76.854 E.0352
G2 X85.716 Y76.623 I-.348 J-.933 E.00892
G1 X85.715 Y73.75 E.05959
G2 X85.575 Y73.425 I-.513 J.029 E.00749
G3 X84.068 Y73.284 I-.555 J-2.19 E.03201
G1 X82.371 Y73.284 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X84.068 Y73.284 E-.64486
G1 X84.357 Y73.374 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 48/73
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.12 I-1.054 J.609 P1  F42000
G1 X102.538 Y104.84 Z6.12
G1 Z5.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3721
M204 S5000
G1 X102.21 Y104.84 E.00632
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.598 Y104.84 E.00756
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14746
G1 X102.21 Y103.228 E-.61254
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.24 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 48 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer48 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z5.84
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3721
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.24 F42000
G1 X85.29 Y104.84 Z6.24
G1 Z5.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3721
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F3721
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X85.106 Y87.035 Z6.24 F42000
G1 X85.213 Y83.067 Z6.24
G1 Z5.84
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3721
M204 S6000
G1 X76.787 Y83.067 E.17478
G3 X75.933 Y82.213 I-.011 J-.842 E.02791
G1 X75.933 Y73.787 E.17477
G3 X76.787 Y72.933 I.842 J-.011 E.02791
G1 X85.26 Y72.935 E.17576
G3 X86.067 Y73.787 I-.031 J.837 E.02695
G1 X86.067 Y82.213 E.17478
G3 X85.273 Y83.065 I-.842 J.011 E.02667
M204 S10000
G1 X85.22 Y83.491 F42000
G1 F3721
M204 S6000
G1 X76.78 Y83.491 E.17506
G3 X75.509 Y82.22 I-.003 J-1.268 E.04143
G1 X75.509 Y73.78 E.17506
G3 X76.78 Y72.509 I1.268 J-.003 E.04143
G1 X85.285 Y72.511 E.17642
G3 X86.491 Y73.78 I-.056 J1.261 E.04012
G1 X86.491 Y82.22 E.17506
G3 X85.28 Y83.489 I-1.268 J.003 E.04019
M204 S250
G1 X85.222 Y83.9 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3721
M204 S5000
G1 X76.773 Y83.9 E.16286
G3 X75.1 Y82.227 I.005 J-1.679 E.05062
G1 X75.1 Y73.773 E.16294
G3 X76.773 Y72.1 I1.679 J.005 E.05062
G1 X85.309 Y72.103 E.16453
G3 X86.9 Y73.773 I-.08 J1.669 E.04908
G1 X86.9 Y82.227 E.16294
G3 X85.282 Y83.899 I-1.679 J-.005 E.04955
; WIPE_START
G1 F12000
M204 S6000
G1 X83.282 Y83.899 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.073 Y82.309 Z6.24 F42000
G1 Z5.84
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3721
M204 S6000
G2 X85.296 Y82.266 I.048 J-.347 E.00479
G1 X85.307 Y82.229 E.00079
G2 X85.309 Y80.807 I-11.546 J-.728 E.02952
G3 X83.615 Y80.235 I-.13 J-2.41 E.03798
G1 X79.836 Y82.597 E.09243
G3 X81.121 Y82.561 I.685 J1.544 E.02734
G1 X80.967 Y82.309 E.00613
M73 P73 R3
G1 X82.368 Y82.309 E.02907
M204 S10000
G1 X83.702 Y79.908 F42000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424542
G1 F3721
M204 S6000
G1 X85.718 Y77.892 E.05559
G1 X85.718 Y77.562 E.00643
G1 X85.573 Y77.472 E.00332
G1 X82.756 Y80.29 E.0777
G1 X81.252 Y81.229 E.03457
G1 X85.226 Y77.255 E.10959
G1 X84.879 Y77.038 E.00798
G1 X79.748 Y82.169 E.14148
G1 X79.082 Y82.585 E.01531
G1 X79.031 Y82.719 E.00279
G1 X78.635 Y82.719 E.00773
G1 X84.532 Y76.821 E.16262
G1 X84.185 Y76.604 E.00798
G1 X78.071 Y82.719 E.1686
G1 X77.988 Y82.719 E.00161
G1 X77.988 Y82.237 E.00939
G1 X83.838 Y76.387 E.16131
G1 X83.491 Y76.17 E.00798
G1 X77.988 Y81.673 E.15174
G1 X77.988 Y81.109 E.011
G1 X83.144 Y75.953 E.14217
G1 X82.797 Y75.736 E.00798
G1 X77.988 Y80.545 E.1326
G1 X77.988 Y79.981 E.011
G1 X82.45 Y75.52 E.12303
G1 X82.103 Y75.303 E.00798
G1 X77.988 Y79.417 E.11346
G1 X77.988 Y78.853 E.011
G1 X81.756 Y75.086 E.10389
G1 X81.409 Y74.869 E.00798
G1 X77.988 Y78.289 E.09432
G1 X77.988 Y77.726 E.011
G1 X81.062 Y74.652 E.08475
G1 X80.715 Y74.435 E.00798
G1 X77.988 Y77.162 E.07518
G1 X77.988 Y76.598 E.011
G1 X80.368 Y74.218 E.06561
G1 X80.021 Y74.001 E.00798
G1 X77.988 Y76.034 E.05604
G1 X77.988 Y75.47 E.011
G1 X79.674 Y73.784 E.04648
G1 X79.326 Y73.567 E.00798
G1 X77.988 Y74.906 E.03691
G1 X77.988 Y74.342 E.011
G1 X79.031 Y73.282 E.029
G1 X78.484 Y73.282 E.01066
G1 X77.811 Y73.955 E.01857
M204 S10000
G1 X76.296 Y74.645 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3721
M204 S6000
G3 X76.362 Y73.534 I2.275 J-.424 E.02331
G3 X76.903 Y73.326 I.401 J.234 E.013
G2 X77.579 Y73.507 I.785 J-1.579 E.0146
G1 X77.579 Y77.044 E.07337
G3 X76.296 Y77.085 I-.694 J-1.643 E.02722
G1 X76.296 Y80.202 E.06465
G2 X77.579 Y80.79 I1.422 J-1.409 E.0299
G1 X77.579 Y82.487 E.0352
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F24749.689
G1 X77.579 Y80.79 E-.64486
G1 X77.286 Y80.712 E-.11514
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 49/73
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.24 I-.841 J.88 P1  F42000
G1 X102.538 Y104.84 Z6.24
G1 Z5.96
G1 E.8 F1800
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6460
M204 S5000
G1 X102.21 Y104.84 E.00631
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.598 Y104.84 E.00756
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14729
G1 X102.21 Y103.228 E-.61271
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.36 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M106 S201.45
M625
; object ids of layer 49 start: 77,88
M624 BgAAAAAAAAA=
M106 S255
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer49 end: 77,88
M106 S201.45
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
G1 X102.6 Y104.635
G1 Z5.96
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6460
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.36 F42000
G1 X85.29 Y104.84 Z6.36
G1 Z5.96
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6460
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F6460
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M106 S201.45
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M106 S255
M204 S10000
G1 X85.101 Y87.035 Z6.36 F42000
G1 X85.206 Y83.053 Z6.36
G1 Z5.96
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6460
M204 S6000
G1 X76.794 Y83.053 E.17449
G3 X75.947 Y82.206 I-.011 J-.836 E.0277
G1 X75.947 Y73.794 E.17449
G3 X76.794 Y72.947 I.836 J-.011 E.0277
G1 X85.255 Y72.949 E.17551
G3 X86.053 Y73.794 I-.033 J.83 E.0267
G1 X86.053 Y82.206 E.1745
G3 X85.266 Y83.052 I-.836 J.011 E.02645
M204 S10000
G1 X85.213 Y83.477 F42000
G1 F6460
M204 S6000
G1 X76.787 Y83.477 E.17478
G3 X75.523 Y82.213 I-.003 J-1.261 E.04121
G1 X75.523 Y73.787 E.17478
G3 X76.787 Y72.523 I1.261 J-.003 E.04121
G1 X85.28 Y72.525 E.17618
G3 X86.477 Y73.787 I-.058 J1.254 E.03985
G1 X86.477 Y82.213 E.17478
G3 X85.273 Y83.476 I-1.261 J.003 E.03997
M204 S250
G1 X85.216 Y83.887 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6460
M204 S5000
G1 X76.78 Y83.887 E.1626
G3 X75.114 Y82.22 I.005 J-1.672 E.05042
G1 X75.114 Y73.78 E.16268
G3 X76.78 Y72.114 I1.672 J.005 E.05042
G1 X85.305 Y72.116 E.16431
G3 X86.887 Y73.78 I-.083 J1.662 E.04883
G1 X86.887 Y82.22 E.16268
G3 X85.276 Y83.885 I-1.672 J-.005 E.04934
; WIPE_START
G1 F12000
M204 S6000
G1 X83.276 Y83.886 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.879 Y78.557 Z6.36 F42000
G1 Z5.96
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42489
; LAYER_HEIGHT: 0.4

M204 S6000
G1 X85.65 Y78.183 E.02533
G1 X85.247 Y78.434 E.02744
G1 X85.676 Y79.136 E.04752
G1 X85.677 Y80.047 E.0526
G1 X84.844 Y78.686 E.09214
G1 X84.442 Y78.938 E.02744
G1 X85.677 Y80.957 E.13675
G1 X85.677 Y81.868 E.0526
G1 X84.039 Y79.189 E.18137
G1 X83.636 Y79.441 E.02744
G1 X85.536 Y82.546 E.2103
G3 X85.459 Y82.603 I-.159 J-.137 E.00557
G3 X85.374 Y82.647 I-.138 J-.16 E.00557
G3 X85.059 Y82.677 I-.248 J-.929 E.01836
G1 X83.234 Y79.693 E.20212
G1 X82.831 Y79.944 E.02744
G1 X84.502 Y82.677 E.18507
G1 X83.946 Y82.677 E.03216
G1 X82.428 Y80.196 E.16803
G1 X82.025 Y80.448 E.02744
G1 X83.389 Y82.677 E.15099
G1 X82.832 Y82.677 E.03216
G1 X81.623 Y80.699 E.13394
G1 X81.22 Y80.951 E.02744
G1 X82.276 Y82.677 E.1169
G1 X81.719 Y82.677 E.03216
G1 X80.711 Y81.03 E.11155
M106 S201.45
M106 S255
M204 S10000
G1 X77.579 Y82.528 F42000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F6460
M204 S6000
G1 X77.579 Y80.831 E.0352
G3 X76.31 Y80.133 I.305 J-2.057 E.03069
G1 X76.31 Y77.203 E.06078
G2 X77.579 Y77.051 I.425 J-1.829 E.02705
G1 X77.579 Y73.548 E.07266
G3 X76.903 Y73.315 I.265 J-1.86 E.01492
G2 X76.374 Y73.545 I-.088 J.521 E.01266
M73 P74 R3
G2 X76.31 Y74.627 I2.3 J.68 E.02269
M204 S10000
G1 X77.988 Y73.356 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F6460
M204 S6000
G1 X77.988 Y82.644 E.17902
G1 X81.189 Y82.644 E.0617
G1 X80.33 Y81.24 E.03173
G1 X80.301 Y81.137 E.00206
G1 X80.394 Y80.969 E.00368
G1 X85.145 Y78 E.10799
G1 X80.024 Y74.8 E.1164
G1 X79.939 Y74.687 E.00273
G1 X79.559 Y73.357 E.02666
G1 X78.048 Y73.356 E.02913
M204 S10000
G1 X81.572 Y79.768 F42000
G1 F6460
M204 S6000
G1 X84.401 Y78 E.0643
G1 X79.816 Y75.134 E.10424
G1 X79.56 Y74.795 E.00818
G1 X79.262 Y73.751 E.02093
G1 X78.382 Y73.751 E.01696
G1 X78.382 Y82.25 E.16382
G1 X80.486 Y82.25 E.04055
G1 X79.994 Y81.445 E.01817
G1 X79.907 Y81.137 E.00618
G1 X79.96 Y80.892 E.00482
G1 X80.185 Y80.635 E.00659
G1 X81.521 Y79.8 E.03038
M204 S10000
G1 X81.363 Y79.434 F42000
G1 F6460
M204 S6000
G1 X83.657 Y78 E.05214
G1 X79.607 Y75.468 E.09208
G1 X79.181 Y74.903 E.01363
G1 X78.965 Y74.145 E.0152
G1 X78.776 Y74.145 E.00363
G1 X78.776 Y81.855 E.14862
G1 X79.783 Y81.855 E.01939
G1 X79.542 Y81.374 E.01038
G1 X79.513 Y81.137 E.0046
G1 X79.601 Y80.73 E.00803
G1 X79.976 Y80.301 E.01098
G1 X81.312 Y79.466 E.03038
M204 S10000
G1 X81.154 Y79.1 F42000
G1 F6460
M204 S6000
G1 X82.914 Y78 E.03999
G1 X79.398 Y75.803 E.07992
G1 X79.171 Y75.501 E.00727
G1 X79.171 Y80.551 E.09735
; LINE_WIDTH: 0.406942
G1 X79.158 Y80.844 E.00546
; LINE_WIDTH: 0.389504
G1 X79.145 Y81.137 E.00521
G1 X79.242 Y80.567 E.01028
; LINE_WIDTH: 0.419992
G1 X79.767 Y79.967 E.01538
G1 X81.103 Y79.131 E.03038
M204 S10000
G1 X80.945 Y78.765 F42000
G1 F6460
M204 S6000
G1 X82.17 Y78 E.02783
G1 X79.565 Y76.372 E.05921
G1 X79.565 Y79.628 E.06276
G1 X80.895 Y78.797 E.03022
M204 S10000
G1 X80.736 Y78.431 F42000
G1 F6460
M204 S6000
G1 X81.426 Y78 E.01567
G1 X79.959 Y77.083 E.03334
G1 X79.959 Y78.917 E.03534
G1 X80.686 Y78.463 E.01651
M204 S10000
G1 X80.506 Y77.933 F42000
; LINE_WIDTH: 0.647592
G1 F6460
M204 S6000
G2 X80.515 Y78.052 I-.036 J.063 E.00951
M204 S10000
G1 X79.165 Y81.467 F42000
; LINE_WIDTH: 0.387942
G1 F6460
M204 S6000
G1 X79.148 Y81.197 E.0048
M204 S10000
G1 X79.771 Y73.121 F42000
; FEATURE: Bridge
; LINE_WIDTH: 0.42489
; LAYER_HEIGHT: 0.4
G1 F1800
M204 S6000
G1 X80.783 Y74.776 E.11208
G1 X81.684 Y75.339 E.0614
G1 X80.451 Y73.323 E.13651
G1 X81.008 Y73.324 E.03216
G1 X82.585 Y75.903 E.17465
G1 X83.487 Y76.466 E.0614
G1 X81.565 Y73.324 E.21279
G1 X82.121 Y73.324 E.03216
G1 X84.388 Y77.029 E.25093
G1 X85.289 Y77.593 E.0614
G1 X82.678 Y73.324 E.28907
G1 X83.235 Y73.324 E.03216
G1 X85.676 Y77.315 E.27026
G1 X85.676 Y76.404 E.0526
G1 X83.792 Y73.324 E.20859
G1 X84.348 Y73.324 E.03216
G1 X85.675 Y75.494 E.14693
G1 X85.675 Y74.583 E.0526
G1 X84.905 Y73.324 E.08526
G1 X85.202 Y73.324 E.01715
G3 X85.545 Y73.46 I.009 J.479 E.02189
G1 X85.878 Y74.004 E.03681
M106 S201.45
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1800
G1 X85.545 Y73.46 E-.2421
G1 X85.4 Y73.362 E-.06658
G1 X85.202 Y73.324 E-.07676
G1 X84.905 Y73.324 E-.11279
G1 X85.265 Y73.912 E-.26178
; WIPE_END
G1 E-.04
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 50/73
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.36 I-1.062 J.593 P1  F42000
G1 X102.537 Y104.84 Z6.36
G1 Z6.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5343
M204 S5000
G1 X102.21 Y104.84 E.00631
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.597 Y104.84 E.00757
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14712
G1 X102.21 Y103.227 E-.61288
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.48 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 50 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer50 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.08
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5343
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.48 F42000
G1 X85.29 Y104.84 Z6.48
G1 Z6.08
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5343
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5343
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X83.784 Y87.114 Z6.48 F42000
G1 X82.701 Y79.781 Z6.48
G1 Z6.08
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5343
M204 S6000
G1 X78.449 Y82.438 E.104
G1 X78.449 Y73.562 E.18411
G1 X85.55 Y78 E.17369
G1 X82.751 Y79.749 E.06844
; WIPE_START
G1 F21000
G1 X81.055 Y80.809 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.025 Y83.04 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
G1 F5343
M204 S6000
G3 X76.73 Y83.037 I-.612 J-19.795 E.02686
G3 X75.961 Y82.2 I.056 J-.823 E.02603
G1 X75.961 Y73.8 E.17422
G3 X76.8 Y72.961 I.829 J-.011 E.02747
G1 X78.025 Y72.961 E.02539
G1 X78.025 Y82.98 E.20782
; WIPE_START
G1 F21000
G1 X76.73 Y83.037 E-.4925
G1 X76.572 Y83.011 E-.06071
G1 X76.42 Y82.954 E-.06183
G1 X76.283 Y82.869 E-.06129
G1 X76.165 Y82.759 E-.06125
G1 X76.131 Y82.711 E-.02242
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.758 Y82.987 Z6.48 F42000
G1 X85.194 Y83.04 Z6.48
G1 Z6.08
G1 E.8 F1800
G1 F5343
M204 S6000
G1 X78.634 Y83.04 E.13606
G1 X78.582 Y82.855 E.00398
G1 X86.04 Y78.194 E.18242
G1 X86.04 Y82.2 E.08308
G3 X85.254 Y83.039 I-.829 J.011 E.02634
; WIPE_START
G1 F21000
G1 X83.254 Y83.039 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.04 Y77.806 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
G1 F5343
M204 S6000
G1 X78.582 Y73.145 E.18242
G1 X78.635 Y72.961 E.00398
G1 X85.25 Y72.962 E.13722
G3 X86.04 Y73.8 I-.035 J.823 E.02644
G1 X86.04 Y77.746 E.08185
; WIPE_START
G1 F21000
G1 X84.337 Y76.696 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.203 Y83.464 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
G1 F5343
M204 S6000
G1 X76.794 Y83.464 E.17443
G3 X75.536 Y82.206 I-.003 J-1.255 E.04099
G1 X75.536 Y73.794 E.1745
G3 X76.794 Y72.536 I1.255 J-.003 E.04099
G1 X85.275 Y72.539 E.17593
G3 X86.464 Y73.794 I-.06 J1.247 E.0396
G1 X86.464 Y82.206 E.1745
G3 X85.263 Y83.463 I-1.255 J.003 E.03982
M204 S250
G1 X85.217 Y83.872 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P75 R3
G1 F5343
M204 S5000
G1 X85.212 Y83.873 E.0001
G1 X76.787 Y83.873 E.1624
G3 X75.127 Y82.213 I.005 J-1.665 E.05021
G1 X75.127 Y73.787 E.16242
G3 X76.787 Y72.127 I1.665 J.005 E.05021
G1 X85.3 Y72.13 E.16409
G3 X86.873 Y73.787 I-.085 J1.656 E.04859
G1 X86.873 Y82.213 E.16242
G3 X85.539 Y83.84 I-1.665 J-.005 E.04388
G1 X85.277 Y83.866 E.00509
; WIPE_START
G1 F12000
M204 S6000
G1 X85.212 Y83.873 E-.02477
G1 X83.277 Y83.873 E-.73523
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.63 Y78.933 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F5343
M204 S6000
G1 X79.715 Y82.63 E.13446
G1 X85.253 Y82.626 E.10675
G1 X85.465 Y82.54 E.00441
G1 X85.564 Y82.427 E.00289
G1 X85.63 Y82.095 E.00654
G1 X85.63 Y78.993 E.05979
M204 S10000
G1 X83.734 Y81.476 F42000
; LINE_WIDTH: 0.357512
G1 F5343
M204 S6000
G1 X84.479 Y81.475 E.01208
G1 X84.479 Y81.01 E.00754
G1 X83.785 Y81.444 E.01327
M204 S10000
G1 X82.467 Y81.839 F42000
; LINE_WIDTH: 0.419992
G1 F5343
M204 S6000
G1 X84.842 Y81.838 E.04578
G1 X84.842 Y80.355 E.02858
G1 X82.518 Y81.808 E.05283
M204 S10000
G1 X81.091 Y82.234 F42000
G1 F5343
M204 S6000
G1 X85.199 Y82.232 E.07919
G1 X85.236 Y82.095 E.00274
G1 X85.236 Y79.644 E.04724
G1 X81.142 Y82.203 E.09306
; WIPE_START
G1 F21000
G1 X82.838 Y81.143 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.783 Y81.837 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; LINE_WIDTH: 0.365752
G1 F5343
M204 S6000
G1 X78.719 Y81.874 E.00122
G1 X78.767 Y81.902 E.00093
; WIPE_START
G1 F21000
G1 X78.719 Y81.874 E-.32875
G1 X78.783 Y81.837 E-.43125
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.288 Y82.788 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.167727
G1 F5343
M204 S6000
G1 X78.321 Y83.02 E.00162
; LINE_WIDTH: 0.20925
G1 X78.353 Y83.252 E.0021
; WIPE_START
G1 F21000
G1 X78.321 Y83.02 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.81 Y78.814 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F5343
M204 S2000
G1 X84.811 Y77.813 E.0273
G1 X84.468 Y77.598
G1 X82.324 Y79.743 E.05847
M204 S10000
G1 X80.837 Y80.672 F42000
G1 F5343
M204 S2000
G1 X84.125 Y77.384 E.08964
G1 X83.782 Y77.169
G1 X79.35 Y81.601 E.12081
G1 X78.692 Y81.702
G1 X83.439 Y76.955 E.12942
G1 X83.096 Y76.74
G1 X78.681 Y81.156 E.12036
G1 X78.681 Y80.598
G1 X82.753 Y76.526 E.11101
G1 X82.41 Y76.311
G1 X78.681 Y80.04 E.10165
G1 X78.681 Y79.483
G1 X82.067 Y76.097 E.0923
G1 X81.724 Y75.882
G1 X78.681 Y78.925 E.08295
G1 X78.681 Y78.368
G1 X81.381 Y75.668 E.0736
G1 X81.037 Y75.454
G1 X78.681 Y77.81 E.06424
G1 X78.681 Y77.253
G1 X80.694 Y75.239 E.05489
G1 X80.351 Y75.025
G1 X78.681 Y76.695 E.04554
G1 X78.681 Y76.138
G1 X80.008 Y74.81 E.03619
G1 X79.665 Y74.596
G1 X78.681 Y75.58 E.02683
G1 X78.681 Y75.023
G1 X79.322 Y74.381 E.01748
; WIPE_START
G1 F12000
M204 S6000
G1 X78.681 Y75.023 E-.34463
G1 X78.681 Y75.58 E-.21187
G1 X79.059 Y75.201 E-.20351
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.774 Y80.608 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.194052
G1 F5343
M204 S6000
G1 X80.575 Y80.766 E.00209
; LINE_WIDTH: 0.14566
G1 X80.376 Y80.925 E.00149
; LINE_WIDTH: 0.0972676
G1 X80.177 Y81.083 E.00089
M204 S10000
G1 X82.26 Y79.679 F42000
; LINE_WIDTH: 0.194053
G1 F5343
M204 S6000
G1 X82.061 Y79.837 E.00209
; LINE_WIDTH: 0.14566
G1 X81.863 Y79.996 E.00149
; LINE_WIDTH: 0.0972678
G1 X81.664 Y80.154 E.00089
M204 S10000
G1 X83.747 Y78.75 F42000
; LINE_WIDTH: 0.194044
G1 F5343
M204 S6000
G1 X83.548 Y78.908 E.00209
; LINE_WIDTH: 0.145655
G1 X83.349 Y79.067 E.00149
; LINE_WIDTH: 0.0972656
G1 X83.15 Y79.225 E.00089
M204 S10000
G1 X84.895 Y77.866 F42000
; LINE_WIDTH: 0.0818592
G1 F5343
M204 S6000
G1 X84.974 Y77.929 E.00028
; LINE_WIDTH: 0.111013
G1 X85.001 Y77.97 E.0002
; LINE_WIDTH: 0.14817
G1 X84.982 Y78.021 E.00032
; LINE_WIDTH: 0.144019
G1 X84.81 Y78.158 E.00128
; LINE_WIDTH: 0.096721
G1 X84.637 Y78.296 E.00077
; WIPE_START
G1 F21000
G1 X84.81 Y78.158 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.629 Y77.067 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F5343
M204 S6000
G1 X85.623 Y73.746 E.06402
G1 X85.515 Y73.528 E.00468
G1 X85.372 Y73.406 E.00363
G1 X85.166 Y73.371 E.00401
G1 X79.714 Y73.37 E.10509
G1 X85.578 Y77.035 E.13329
M204 S10000
G1 X83.73 Y74.522 F42000
; LINE_WIDTH: 0.357072
G1 F5343
M204 S6000
G1 X84.474 Y74.987 E.01421
G1 X84.473 Y74.523 E.00753
G1 X83.79 Y74.522 E.01107
M204 S10000
G1 X82.464 Y74.159 F42000
; LINE_WIDTH: 0.419992
G1 F5343
M204 S6000
G1 X84.838 Y75.643 E.05395
G1 X84.835 Y74.16 E.02858
G1 X82.524 Y74.159 E.04454
M204 S10000
G1 X81.089 Y73.765 F42000
G1 F5343
M204 S6000
G1 X85.233 Y76.355 E.0942
G1 X85.229 Y73.808 E.04909
G1 X85.166 Y73.766 E.00145
G1 X81.149 Y73.765 E.07743
; WIPE_START
G1 F21000
G1 X83.149 Y73.765 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.353 Y72.748 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.20964
G1 F5343
M204 S6000
G1 X78.321 Y72.98 E.0021
; LINE_WIDTH: 0.168181
G1 X78.288 Y73.212 E.00163
; WIPE_START
G1 F21000
G1 X78.321 Y72.98 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.783 Y74.089 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F5343
M204 S6000
G1 X78.719 Y74.126 E.00122
G1 X78.767 Y74.154 E.00093
; WIPE_START
G1 F21000
G1 X78.719 Y74.126 E-.32877
G1 X78.783 Y74.089 E-.43123
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.615 Y73.997 Z6.48 F42000
G1 Z6.08
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F5343
M204 S6000
G1 X77.615 Y73.372 E.01205
G1 X76.727 Y73.377 E.01712
G1 X76.473 Y73.522 E.00564
G1 X76.372 Y73.777 E.00528
G1 X76.377 Y82.27 E.16371
G1 X76.499 Y82.488 E.00481
G1 X76.651 Y82.602 E.00365
G1 X77.615 Y82.63 E.01861
G1 X77.615 Y74.057 E.16525
M204 S10000
G1 X77.206 Y73.997 F42000
; LINE_WIDTH: 0.448958
G1 F5343
M204 S6000
G1 X77.206 Y73.784 E.00442
G1 X76.787 Y73.802 E.00869
G1 X76.785 Y82.011 E.16986
G1 X76.802 Y82.212 E.00417
G1 X77.207 Y82.222 E.00839
G1 X77.206 Y74.057 E.16895
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F16800
G1 X77.206 Y76.057 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 51/73
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.48 I-.914 J.804 P1  F42000
G1 X102.537 Y104.84 Z6.48
G1 Z6.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4515
M204 S5000
G1 X102.21 Y104.84 E.0063
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.597 Y104.84 E.00758
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14696
G1 X102.21 Y103.227 E-.61304
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 51 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer51 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
M73 P75 R2
G1 F4515
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.6 F42000
G1 X85.29 Y104.84 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4515
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4515
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.324 Y87.48 Z6.6 F42000
G1 X80.032 Y81.086 Z6.6
G1 Z6.2
M73 P76 R2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4515
M204 S6000
G1 X78.757 Y81.883 E.03119
G1 X78.757 Y74.117 E.16107
G1 X84.969 Y78 E.15196
G1 X80.083 Y81.054 E.11952
M204 S10000
G1 X79.807 Y80.726 F42000
G1 F4515
M204 S6000
G1 X79.181 Y81.117 E.01532
G1 X79.181 Y74.883 E.12932
G1 X84.168 Y78 E.122
G1 X79.858 Y80.694 E.10544
M204 S250
G1 X79.59 Y80.379 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4515
M204 S5000
G1 X79.59 Y75.621 E.09171
G1 X83.396 Y78 E.08652
G1 X79.641 Y80.347 E.08536
; WIPE_START
G1 F12000
M204 S6000
G1 X79.619 Y78.347 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.193 Y83.026 Z6.6 F42000
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4515
M204 S6000
G1 X76.807 Y83.026 E.17393
G3 X75.974 Y82.193 I-.011 J-.822 E.02726
G1 X75.974 Y73.807 E.17393
G3 X76.807 Y72.974 I.822 J-.011 E.02726
G1 X85.245 Y72.976 E.17502
G3 X86.026 Y73.807 I-.036 J.817 E.02619
G1 X86.026 Y82.193 E.17393
G3 X85.253 Y83.025 I-.822 J.011 E.02601
M204 S10000
G1 X85.2 Y83.45 F42000
G1 F4515
M204 S6000
G1 X76.8 Y83.45 E.17422
G3 X75.55 Y82.2 I-.003 J-1.248 E.04077
G1 X75.55 Y73.8 E.17422
G3 X76.8 Y72.55 I1.248 J-.003 E.04077
G1 X85.271 Y72.552 E.1757
G3 X86.45 Y73.8 I-.062 J1.24 E.03933
G1 X86.45 Y82.2 E.17422
G3 X85.26 Y83.449 I-1.248 J.003 E.03953
M204 S250
G1 X85.211 Y83.859 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4515
M204 S5000
G1 X85.206 Y83.859 E.0001
G1 X76.794 Y83.859 E.16216
G3 X75.141 Y82.206 I.005 J-1.659 E.05001
G1 X75.141 Y73.794 E.16216
G3 X76.794 Y72.141 I1.659 J.005 E.05001
G1 X85.295 Y72.143 E.16388
G3 X86.859 Y73.794 I-.087 J1.649 E.04834
G1 X86.859 Y82.206 E.16216
G3 X85.531 Y83.826 I-1.659 J-.005 E.0437
G1 X85.271 Y83.853 E.00504
; WIPE_START
G1 F12000
M204 S6000
G1 X85.206 Y83.859 E-.02474
G1 X83.271 Y83.859 E-.73526
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.396 Y77.284 Z6.6 F42000
G1 X77.561 Y74.17 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.416397
G1 F4515
M204 S6000
G1 X77.17 Y74.17 E.00746
G1 X77.17 Y81.83 E.1463
G1 X77.561 Y81.83 E.00746
G1 X77.561 Y74.23 E.14516
M204 S10000
G1 X77.953 Y73.778 F42000
; LINE_WIDTH: 0.419992
G1 F4515
M204 S6000
G1 X76.84 Y73.778 E.02145
G1 X76.796 Y73.819 E.00116
G1 X76.778 Y74.365 E.01055
G1 X76.778 Y82.156 E.15016
G1 X76.817 Y82.203 E.00119
G2 X77.953 Y82.223 I.843 J-16.034 E.02191
G1 X77.953 Y73.838 E.16162
M204 S10000
G1 X81.105 Y74.173 F42000
G1 F4515
M204 S6000
G1 X84.827 Y76.499 E.0846
G1 X84.826 Y74.173 E.04483
G1 X81.165 Y74.173 E.07057
M204 S10000
G1 X82.48 Y74.567 F42000
G1 F4515
M204 S6000
G1 X84.432 Y75.787 E.04438
G1 X84.432 Y74.568 E.02351
G1 X82.54 Y74.567 E.03647
M204 S10000
G1 X84.027 Y74.951 F42000
; LINE_WIDTH: 0.501492
G1 F4515
M204 S6000
G2 X84.026 Y75.054 I-.03 J.051 E.00577
M204 S10000
G1 X83.14 Y76.374 F42000
; LINE_WIDTH: 0.427156
G1 F4515
M204 S6000
G1 X85.478 Y77.826 E.05402
G1 X85.591 Y78 E.00408
G1 X85.607 Y77.754 E.00483
G2 X85.614 Y73.871 I-598.177 J-3.154 E.07621
G1 X85.538 Y73.563 E.00623
G1 X85.356 Y73.433 E.00439
G1 X85.128 Y73.385 E.00457
G1 X83.997 Y73.385 E.02219
; LINE_WIDTH: 0.443167
G1 X81.349 Y73.407 E.05404
; LINE_WIDTH: 0.489517
G1 X78.702 Y73.43 E.06004
; LINE_WIDTH: 0.527937
G1 X78.623 Y73.445 E.00196
; LINE_WIDTH: 0.548589
G1 X78.544 Y73.46 E.00205
G1 X78.673 Y73.528 E.00372
; LINE_WIDTH: 0.489517
G1 X80.881 Y74.935 E.05936
; LINE_WIDTH: 0.443167
G1 X83.089 Y76.342 E.05343
M204 S10000
G1 X85.221 Y77.21 F42000
; LINE_WIDTH: 0.419992
G1 F4515
M204 S6000
G1 X85.22 Y73.871 E.06436
G2 X85.128 Y73.779 I-.072 J-.02 E.00305
G1 X79.73 Y73.778 E.10405
G1 X85.17 Y77.179 E.12366
M204 S10000
G1 X85.222 Y78.79 F42000
G1 F4515
M204 S6000
G1 X79.729 Y82.223 E.12485
G1 X85.156 Y82.222 E.1046
G2 X85.222 Y82.088 I-.049 J-.108 E.00313
G1 X85.222 Y78.85 E.06242
M204 S10000
G1 X83.14 Y79.626 F42000
; LINE_WIDTH: 0.439044
G1 F4515
M204 S6000
G1 X81.653 Y80.577 E.03568
; LINE_WIDTH: 0.477147
G1 X80.166 Y81.529 E.03896
; LINE_WIDTH: 0.515251
G1 X78.679 Y82.481 E.04225
; LINE_WIDTH: 0.556387
G1 X78.592 Y82.538 E.00269
G1 X78.702 Y82.56 E.0029
; LINE_WIDTH: 0.515251
G1 X80.467 Y82.579 E.04225
; LINE_WIDTH: 0.477147
G1 X82.233 Y82.598 E.03896
; LINE_WIDTH: 0.428812
G2 X85.174 Y82.617 I2.352 J-136.166 E.05796
G1 X85.461 Y82.521 E.00597
G1 X85.569 Y82.347 E.00404
G1 X85.617 Y82.088 E.00519
G2 X85.604 Y78.246 I-440.194 J-.428 E.07571
; LINE_WIDTH: 0.458302
G1 X85.589 Y78.039 E.0044
G1 X85.48 Y78.178 E.00374
; LINE_WIDTH: 0.431982
G1 X83.191 Y79.594 E.05346
M204 S10000
G1 X84.028 Y80.947 F42000
; LINE_WIDTH: 0.503072
G1 F4515
M204 S6000
G2 X84.027 Y81.05 I-.03 J.052 E.00582
M204 S10000
G1 X82.478 Y81.434 F42000
; LINE_WIDTH: 0.419992
G1 F4515
M204 S6000
G1 X84.434 Y81.434 E.03769
G1 X84.433 Y80.212 E.02355
G1 X82.529 Y81.402 E.04328
M204 S10000
G1 X81.104 Y81.828 F42000
G1 F4515
M204 S6000
G1 X84.828 Y81.828 E.07179
G1 X84.828 Y79.501 E.04486
G1 X81.154 Y81.796 E.08349
M204 S10000
G1 X78.347 Y82.265 F42000
G1 F4515
M204 S6000
G1 X78.347 Y73.734 E.16444
; LINE_WIDTH: 0.439722
G1 X78.385 Y73.666 E.00157
; LINE_WIDTH: 0.479182
G1 X78.422 Y73.598 E.00172
; LINE_WIDTH: 0.518642
G1 X78.459 Y73.531 E.00187
; LINE_WIDTH: 0.558102
G1 X78.497 Y73.463 E.00202
G1 X78.372 Y73.443 E.0033
; LINE_WIDTH: 0.518642
G1 X78.247 Y73.423 E.00305
; LINE_WIDTH: 0.479182
G1 X78.122 Y73.403 E.00281
; LINE_WIDTH: 0.420197
G1 X77.996 Y73.384 E.00244
G1 X76.825 Y73.383 E.0226
G1 X76.538 Y73.48 E.00584
G1 X76.432 Y73.651 E.00389
G1 X76.383 Y73.912 E.00511
G1 X76.383 Y82.174 E.15933
G1 X76.476 Y82.458 E.00578
G1 X76.656 Y82.569 E.00407
G1 X76.912 Y82.617 E.00503
G1 X77.996 Y82.617 E.0209
; LINE_WIDTH: 0.439282
G1 X78.133 Y82.597 E.0028
; LINE_WIDTH: 0.477862
G1 X78.27 Y82.578 E.00306
; LINE_WIDTH: 0.516442
G1 X78.407 Y82.559 E.00332
; LINE_WIDTH: 0.555022
G1 X78.544 Y82.54 E.00358
G1 X78.504 Y82.483 E.0018
; LINE_WIDTH: 0.516442
G1 X78.463 Y82.427 E.00167
; LINE_WIDTH: 0.477862
G1 X78.423 Y82.37 E.00153
; LINE_WIDTH: 0.439282
G1 X78.382 Y82.314 E.0014
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X78.423 Y82.37 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 52/73
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.6 I-.83 J.89 P1  F42000
G1 X102.536 Y104.84 Z6.6
G1 Z6.32
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4475
M204 S5000
G1 X102.21 Y104.84 E.00629
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.596 Y104.84 E.00759
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.1468
G1 X102.21 Y103.226 E-.6132
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.72 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 52 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer52 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.32
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4475
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.72 F42000
G1 X85.29 Y104.84 Z6.72
G1 Z6.32
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4475
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4475
M204 S6000
M73 P77 R2
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.324 Y87.48 Z6.72 F42000
G1 X80.032 Y81.086 Z6.72
G1 Z6.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4475
M204 S6000
G1 X78.757 Y81.883 E.03119
G1 X78.757 Y74.117 E.16107
G1 X84.969 Y78 E.15195
G1 X80.083 Y81.054 E.11951
M204 S10000
G1 X79.807 Y80.726 F42000
G1 F4475
M204 S6000
G1 X79.181 Y81.117 E.01532
G1 X79.181 Y74.883 E.12932
G1 X84.168 Y78 E.122
G1 X79.858 Y80.694 E.10544
M204 S250
G1 X79.59 Y80.379 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4475
M204 S5000
G1 X79.59 Y75.621 E.09171
G1 X83.396 Y78 E.08652
G1 X79.641 Y80.347 E.08536
; WIPE_START
G1 F12000
M204 S6000
G1 X79.619 Y78.347 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.186 Y83.012 Z6.72 F42000
G1 Z6.32
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4475
M204 S6000
G1 X76.814 Y83.012 E.17365
G3 X75.988 Y82.186 I-.011 J-.816 E.02702
G1 X75.988 Y73.814 E.17366
G3 X76.814 Y72.988 I.816 J-.011 E.02702
G1 X85.24 Y72.989 E.17478
G3 X86.012 Y73.814 I-.038 J.81 E.02593
G1 X86.012 Y82.186 E.17366
G3 X85.246 Y83.011 I-.816 J.011 E.02578
M204 S10000
G1 X85.193 Y83.437 F42000
G1 F4475
M204 S6000
G1 X76.807 Y83.437 E.17394
G3 X75.563 Y82.193 I-.003 J-1.241 E.04055
G1 X75.563 Y73.807 E.17394
G3 X76.807 Y72.563 I1.241 J-.003 E.04055
G1 X85.266 Y72.566 E.17545
G3 X86.437 Y73.807 I-.064 J1.233 E.03908
G1 X86.437 Y82.193 E.17394
G3 X85.253 Y83.435 I-1.241 J.003 E.03931
M204 S250
G1 X85.206 Y83.845 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4475
M204 S5000
G1 X85.2 Y83.846 E.00012
G1 X76.8 Y83.846 E.1619
G3 X75.154 Y82.2 I.005 J-1.652 E.0498
G1 X75.154 Y73.8 E.1619
G3 X76.8 Y72.154 I1.652 J.005 E.0498
G1 X85.291 Y72.157 E.16365
G3 X86.846 Y73.8 I-.089 J1.642 E.0481
G1 X86.846 Y82.2 E.1619
G3 X85.523 Y83.813 I-1.652 J-.005 E.04352
G1 X85.266 Y83.839 E.00499
; WIPE_START
G1 F12000
M204 S6000
G1 X85.2 Y83.846 E-.02521
G1 X83.266 Y83.846 E-.73479
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.125 Y81.815 Z6.72 F42000
G1 Z6.32
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4475
M204 S6000
G1 X84.815 Y81.815 E.07112
G1 X84.814 Y79.509 E.04444
G1 X81.176 Y81.783 E.08269
M204 S10000
G1 X82.5 Y81.421 F42000
G1 F4475
M204 S6000
G1 X84.42 Y81.42 E.03702
G1 X84.42 Y80.22 E.02313
G1 X82.551 Y81.389 E.04249
M204 S10000
G1 X84.021 Y80.942 F42000
; LINE_WIDTH: 0.487592
G1 F4475
M204 S6000
G2 X84.019 Y81.042 I-.029 J.049 E.00536
M204 S10000
G1 X83.138 Y79.627 F42000
; LINE_WIDTH: 0.437554
G1 F4475
M204 S6000
G1 X81.651 Y80.577 E.03553
; LINE_WIDTH: 0.472677
G1 X80.164 Y81.527 E.03856
; LINE_WIDTH: 0.507801
G1 X78.677 Y82.477 E.0416
; LINE_WIDTH: 0.545027
G1 X78.591 Y82.531 E.00257
G1 X78.698 Y82.551 E.00276
; LINE_WIDTH: 0.507801
G1 X80.463 Y82.568 E.0416
; LINE_WIDTH: 0.472677
G1 X82.227 Y82.586 E.03856
; LINE_WIDTH: 0.428697
G2 X85.167 Y82.603 I2.351 J-147.573 E.05791
G1 X85.448 Y82.512 E.00582
G1 X85.556 Y82.336 E.00407
G1 X85.603 Y82.083 E.00508
G2 X85.582 Y78.037 I-264.766 J-.664 E.07969
G1 X85.478 Y78.175 E.0034
G1 X83.189 Y79.595 E.05307
M204 S10000
G1 X85.208 Y78.798 F42000
; LINE_WIDTH: 0.419992
G1 F4475
M204 S6000
G1 X79.751 Y82.209 E.12405
G1 X85.149 Y82.209 E.10405
G2 X85.209 Y82.083 I-.048 J-.1 E.00292
G1 X85.208 Y78.858 E.06216
M204 S10000
G1 X85.208 Y77.202 F42000
G1 F4475
M204 S6000
G1 X85.207 Y73.877 E.06408
G2 X85.122 Y73.793 I-.066 J-.019 E.00281
G1 X79.752 Y73.792 E.10352
G1 X85.157 Y77.17 E.12286
M204 S10000
G1 X83.138 Y76.373 F42000
; LINE_WIDTH: 0.425447
G1 F4475
M204 S6000
G1 X85.477 Y77.827 E.05381
G1 X85.584 Y78 E.00397
G1 X85.595 Y77.762 E.00466
G2 X85.601 Y73.877 I-775.646 J-3.106 E.07591
G1 X85.526 Y73.573 E.00613
G1 X85.348 Y73.446 E.00426
G1 X85.122 Y73.399 E.00451
G1 X83.992 Y73.398 E.02209
; LINE_WIDTH: 0.44149
G1 X81.345 Y73.419 E.05381
; LINE_WIDTH: 0.484485
G1 X78.698 Y73.44 E.05937
; LINE_WIDTH: 0.519555
G1 X78.621 Y73.454 E.00188
; LINE_WIDTH: 0.537926
G1 X78.544 Y73.467 E.00195
G1 X78.672 Y73.531 E.00356
; LINE_WIDTH: 0.484485
G1 X80.88 Y74.936 E.0587
; LINE_WIDTH: 0.44149
G1 X83.088 Y76.341 E.0532
M204 S10000
G1 X84.02 Y74.958 F42000
; LINE_WIDTH: 0.485772
G1 F4475
M204 S6000
G2 X84.018 Y75.058 I-.029 J.049 E.00531
M204 S10000
G1 X82.502 Y74.581 F42000
; LINE_WIDTH: 0.419992
G1 F4475
M204 S6000
G1 X84.419 Y75.779 E.04358
G1 X84.418 Y74.581 E.02309
G1 X82.562 Y74.581 E.03579
M204 S10000
G1 X81.127 Y74.186 F42000
G1 F4475
M204 S6000
G1 X84.813 Y76.49 E.0838
G1 X84.813 Y74.187 E.0444
G1 X81.187 Y74.186 E.06989
M204 S10000
G1 X78.347 Y73.735 F42000
; LINE_WIDTH: 0.444046
G1 F4475
M204 S6000
G1 X78.398 Y73.646 E.00208
; LINE_WIDTH: 0.492152
G1 X78.448 Y73.558 E.00232
; LINE_WIDTH: 0.540259
G1 X78.498 Y73.469 E.00256
G1 X78.335 Y73.445 E.00414
; LINE_WIDTH: 0.492152
G1 X78.173 Y73.421 E.00375
; LINE_WIDTH: 0.420316
G1 X78.01 Y73.397 E.00317
G1 X76.831 Y73.397 E.02274
G1 X76.549 Y73.491 E.00574
G1 X76.445 Y73.66 E.00383
G1 X76.397 Y73.918 E.00505
G1 X76.397 Y82.167 E.15914
G1 X76.488 Y82.448 E.00569
G1 X76.664 Y82.557 E.00399
G1 X76.917 Y82.603 E.00496
G1 X78.01 Y82.603 E.02107
; LINE_WIDTH: 0.443432
G1 X78.188 Y82.58 E.00367
; LINE_WIDTH: 0.490312
G1 X78.366 Y82.556 E.00408
; LINE_WIDTH: 0.537192
G1 X78.544 Y82.533 E.0045
G1 X78.479 Y82.444 E.00277
; LINE_WIDTH: 0.490312
G1 X78.413 Y82.355 E.00252
; LINE_WIDTH: 0.420295
G1 X78.347 Y82.265 E.00214
G1 X78.347 Y73.795 E.1634
M204 S10000
G1 X77.953 Y73.791 F42000
; LINE_WIDTH: 0.419992
G1 F4475
M204 S6000
G1 X76.847 Y73.791 E.02132
G1 X76.791 Y73.902 E.0024
G1 X76.791 Y82.149 E.15896
G1 X76.825 Y82.19 E.00103
G2 X77.953 Y82.209 I.838 J-16.234 E.02175
G1 X77.953 Y73.851 E.1611
M204 S10000
G1 X77.564 Y74.18 F42000
; LINE_WIDTH: 0.409637
G1 F4475
M204 S6000
G1 X77.18 Y74.18 E.00721
G1 X77.18 Y81.82 E.14339
G1 X77.564 Y81.82 E.00721
G1 X77.564 Y74.24 E.14226
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X77.564 Y76.24 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 53/73
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.72 I-.917 J.8 P1  F42000
G1 X102.536 Y104.84 Z6.72
G1 Z6.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4560
M204 S5000
G1 X102.21 Y104.84 E.00628
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.596 Y104.84 E.0076
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14664
G1 X102.21 Y103.226 E-.61336
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.84 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 53 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer53 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.44
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4560
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.84 F42000
G1 X85.29 Y104.84 Z6.84
G1 Z6.44
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P78 R2
G1 F4560
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4560
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.324 Y87.48 Z6.84 F42000
G1 X80.032 Y81.086 Z6.84
G1 Z6.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4560
M204 S6000
G1 X78.757 Y81.883 E.03119
G1 X78.757 Y74.117 E.16107
G1 X84.969 Y78 E.15196
G1 X80.083 Y81.054 E.11952
M204 S10000
G1 X79.807 Y80.726 F42000
G1 F4560
M204 S6000
G1 X79.181 Y81.117 E.01532
G1 X79.181 Y74.883 E.12932
G1 X84.168 Y78 E.122
G1 X79.858 Y80.694 E.10544
M204 S250
G1 X79.59 Y80.379 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4560
M204 S5000
G1 X79.59 Y75.621 E.09171
G1 X83.396 Y78 E.08652
G1 X79.641 Y80.347 E.08536
; WIPE_START
G1 F12000
M204 S6000
G1 X79.619 Y78.347 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.179 Y82.999 Z6.84 F42000
G1 Z6.44
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4560
M204 S6000
G1 X76.821 Y82.999 E.17338
G3 X76.001 Y82.179 I-.011 J-.808 E.02681
G1 X76.001 Y73.821 E.17338
G3 X76.821 Y73.001 I.808 J-.011 E.02681
G1 X85.235 Y73.003 E.17453
G3 X85.999 Y73.821 I-.04 J.803 E.02568
G1 X85.999 Y82.179 E.17338
G3 X85.239 Y82.998 I-.808 J.011 E.02556
M204 S10000
G1 X85.186 Y83.423 F42000
G1 F4560
M204 S6000
G1 X76.814 Y83.423 E.17366
G3 X75.577 Y82.186 I-.003 J-1.234 E.04033
G1 X75.577 Y73.814 E.17366
G3 X76.814 Y72.577 I1.234 J-.003 E.04033
G1 X85.261 Y72.579 E.17522
G3 X86.423 Y73.814 I-.066 J1.226 E.03881
G1 X86.423 Y82.186 E.17366
G3 X85.246 Y83.422 I-1.234 J.003 E.03908
M204 S250
G1 X85.2 Y83.832 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4560
M204 S5000
G1 X85.193 Y83.832 E.00015
G1 X76.807 Y83.832 E.16164
G3 X75.168 Y82.193 I.005 J-1.645 E.0496
G1 X75.168 Y73.807 E.16164
G3 X76.807 Y72.168 I1.645 J.005 E.0496
G1 X85.286 Y72.171 E.16343
G3 X86.832 Y73.807 I-.091 J1.635 E.04785
G1 X86.832 Y82.193 E.16164
G3 X85.515 Y83.799 I-1.645 J-.005 E.04334
G1 X85.26 Y83.826 E.00494
; WIPE_START
G1 F12000
M204 S6000
G1 X85.193 Y83.832 E-.0257
G1 X83.26 Y83.832 E-.7343
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.59 Y82.787 Z6.84 F42000
G1 Z6.44
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0927778
G1 F4560
M204 S6000
G1 X78.568 Y82.627 E.00053
M204 S10000
G1 X77.567 Y74.208 F42000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.402872
G1 F4560
M204 S6000
G1 X77.19 Y74.19 E.00696
G1 X77.19 Y81.81 E.14049
G1 X77.567 Y81.793 E.00696
G1 X77.567 Y74.268 E.13875
; WIPE_START
G1 F21000
G1 X77.567 Y76.268 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.148 Y74.2 Z6.84 F42000
G1 Z6.44
G1 E.8 F1800
; LINE_WIDTH: 0.419992
G1 F4560
M204 S6000
G1 X84.8 Y76.482 E.083
G1 X84.799 Y74.201 E.04397
G1 X81.208 Y74.2 E.06921
M204 S10000
G1 X82.523 Y74.594 F42000
G1 F4560
M204 S6000
G1 X84.405 Y75.77 E.04278
G1 X84.405 Y74.595 E.02266
G1 X82.583 Y74.594 E.03511
M204 S10000
G1 X84.014 Y74.966 F42000
; LINE_WIDTH: 0.470052
G1 F4560
M204 S6000
G2 X84.009 Y75.062 I-.028 J.047 E.00487
M204 S10000
G1 X83.137 Y76.372 F42000
; LINE_WIDTH: 0.421629
G1 F4560
M204 S6000
G1 X85.476 Y77.829 E.05334
G1 X85.577 Y78 E.00385
G1 X85.584 Y77.769 E.00447
G2 X85.587 Y73.882 I-1188.707 J-2.995 E.07523
G1 X85.513 Y73.583 E.00597
G1 X85.353 Y73.467 E.00383
G1 X85.107 Y73.412 E.00489
G1 X79.023 Y73.411 E.11776
G1 X78.99 Y73.646 E.0046
G1 X78.892 Y73.72 E.00236
G1 X83.086 Y76.341 E.09572
M204 S10000
G1 X85.194 Y77.193 F42000
; LINE_WIDTH: 0.419992
G1 F4560
M204 S6000
G1 X85.193 Y73.882 E.06382
G2 X85.106 Y73.806 I-.085 J.009 E.00244
G1 X79.773 Y73.805 E.1028
G1 X85.143 Y77.161 E.12206
M204 S10000
G1 X85.195 Y78.806 F42000
G1 F4560
M204 S6000
G1 X79.772 Y82.195 E.12325
G1 X85.142 Y82.195 E.10351
G1 X85.195 Y82.091 E.00225
G1 X85.195 Y78.866 E.06216
M204 S10000
G1 X83.137 Y79.628 F42000
; LINE_WIDTH: 0.422125
G1 F4560
M204 S6000
G1 X78.892 Y82.281 E.09701
G1 X78.994 Y82.384 E.00281
G1 X79.023 Y82.59 E.00402
G1 X85.16 Y82.59 E.11894
G1 X85.406 Y82.521 E.00495
G1 X85.527 Y82.393 E.00342
G1 X85.59 Y82.077 E.00624
G2 X85.576 Y78.036 I-415.731 J-.598 E.07831
G1 X85.477 Y78.172 E.00326
G1 X83.188 Y79.596 E.05224
M204 S10000
G1 X84.014 Y80.939 F42000
; LINE_WIDTH: 0.471852
G1 F4560
M204 S6000
G2 X84.01 Y81.035 I-.028 J.047 E.00492
M204 S10000
G1 X82.521 Y81.407 F42000
; LINE_WIDTH: 0.419992
G1 F4560
M204 S6000
G1 X84.407 Y81.407 E.03634
G1 X84.406 Y80.229 E.02271
G1 X82.572 Y81.375 E.04169
M204 S10000
G1 X81.147 Y81.801 F42000
G1 F4560
M204 S6000
G1 X84.801 Y81.801 E.07044
G1 X84.8 Y79.518 E.04402
G1 X81.198 Y81.769 E.08189
; WIPE_START
G1 F21000
G1 X82.894 Y80.709 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.347 Y81.621 Z6.84 F42000
G1 Z6.44
G1 E.8 F1800
; LINE_WIDTH: 0.419592
G1 F4560
M204 S6000
G1 X78.347 Y74.227 E.14238
G1 X78.359 Y73.848 E.0073
G1 X78.412 Y73.735 E.00241
; LINE_WIDTH: 0.386216
G1 X78.542 Y73.659 E.00264
G1 X78.256 Y73.73 E.00518
; LINE_WIDTH: 0.419946
G1 X78.136 Y73.679 E.00252
G3 X78.102 Y73.411 I.27 J-.17 E.00538
G1 X76.838 Y73.41 E.02436
G1 X76.593 Y73.479 E.00491
G1 X76.473 Y73.607 E.00338
G1 X76.41 Y73.923 E.00621
G1 X76.41 Y82.16 E.15876
G1 X76.5 Y82.437 E.0056
G1 X76.673 Y82.544 E.00392
G1 X76.923 Y82.59 E.00489
G1 X78.102 Y82.59 E.02273
G3 X78.136 Y82.321 I.304 J-.098 E.00539
G1 X78.256 Y82.267 E.00254
; LINE_WIDTH: 0.403575
G1 X78.405 Y82.303 E.00284
; LINE_WIDTH: 0.378794
G1 X78.555 Y82.339 E.00266
G1 X78.409 Y82.265 E.00282
; LINE_WIDTH: 0.415207
G1 X78.356 Y82.152 E.00239
G1 X78.348 Y81.681 E.00896
M204 S10000
G1 X77.953 Y81.998 F42000
; LINE_WIDTH: 0.419992
G1 F4560
M204 S6000
G1 X77.953 Y74.002 E.15414
G1 X77.844 Y73.944 E.00238
G1 X77.801 Y73.805 E.0028
G1 X76.855 Y73.805 E.01823
G1 X76.805 Y73.909 E.00223
G1 X76.805 Y82.142 E.1587
G1 X76.909 Y82.195 E.00225
G1 X77.801 Y82.195 E.0172
G1 X77.844 Y82.056 E.0028
G1 X77.9 Y82.027 E.00123
M204 S10000
G1 X78.568 Y73.373 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0927815
G1 F4560
M204 S6000
G1 X78.59 Y73.213 E.00053
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X78.568 Y73.373 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 54/73
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.84 I-.968 J.737 P1  F42000
G1 X102.535 Y104.84 Z6.84
G1 Z6.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4482
M204 S5000
G1 X102.21 Y104.84 E.00627
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.595 Y104.84 E.00761
; WIPE_START
M73 P79 R2
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14648
G1 X102.21 Y103.225 E-.61352
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z6.96 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 54 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer54 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.56
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4482
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z6.96 F42000
G1 X85.29 Y104.84 Z6.96
G1 Z6.56
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4482
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4482
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.324 Y87.48 Z6.96 F42000
G1 X80.032 Y81.086 Z6.96
G1 Z6.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4482
M204 S6000
G1 X78.757 Y81.883 E.03119
G1 X78.757 Y74.117 E.16107
G1 X84.969 Y78 E.15196
G1 X80.083 Y81.054 E.11952
M204 S10000
G1 X79.807 Y80.726 F42000
G1 F4482
M204 S6000
G1 X79.181 Y81.117 E.01532
G1 X79.181 Y74.883 E.12932
G1 X84.168 Y78 E.122
G1 X79.858 Y80.694 E.10544
M204 S250
G1 X79.59 Y80.379 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4482
M204 S5000
G1 X79.59 Y75.621 E.09171
G1 X83.396 Y78 E.08652
G1 X79.641 Y80.347 E.08536
; WIPE_START
G1 F12000
M204 S6000
G1 X79.619 Y78.347 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.172 Y82.985 Z6.96 F42000
G1 Z6.56
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4482
M204 S6000
G1 X76.827 Y82.985 E.1731
G3 X76.015 Y82.172 I-.011 J-.802 E.02658
G1 X76.015 Y73.827 E.1731
G3 X76.828 Y73.015 I.802 J-.011 E.02659
G1 X85.23 Y73.017 E.17428
G3 X85.985 Y73.828 I-.042 J.796 E.02542
G1 X85.985 Y82.173 E.1731
G3 X85.232 Y82.984 I-.802 J.011 E.02534
M204 S10000
G1 X85.179 Y83.41 F42000
G1 F4482
M204 S6000
G1 X76.821 Y83.41 E.17338
G3 X75.59 Y82.179 I-.003 J-1.228 E.04011
G1 X75.59 Y73.821 E.17338
G3 X76.821 Y72.59 I1.228 J-.003 E.04011
G1 X85.256 Y72.593 E.17497
G3 X86.41 Y73.821 I-.068 J1.22 E.03856
G1 X86.41 Y82.179 E.17338
G3 X85.239 Y83.408 I-1.228 J.003 E.03886
M204 S250
G1 X85.195 Y83.818 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4482
M204 S5000
G1 X85.186 Y83.819 E.00017
G1 X76.814 Y83.819 E.16138
G3 X75.181 Y82.186 I.005 J-1.638 E.04939
G1 X75.181 Y73.814 E.16138
G3 X76.814 Y72.181 I1.638 J.005 E.04939
G1 X85.281 Y72.184 E.16321
G3 X86.819 Y73.814 I-.093 J1.628 E.04761
G1 X86.819 Y82.186 E.16138
G3 X85.507 Y83.786 I-1.638 J-.005 E.04316
G1 X85.255 Y83.812 E.00489
; WIPE_START
G1 F12000
M204 S6000
G1 X85.186 Y83.819 E-.02623
G1 X83.255 Y83.819 E-.73378
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.601 Y82.773 Z6.96 F42000
G1 Z6.56
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102088
G1 F4482
M204 S6000
G1 X78.568 Y82.538 E.00089
M204 S10000
G1 X77.571 Y81.614 F42000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.396112
G1 F4482
M204 S6000
G1 X77.571 Y74.283 E.13276
G1 X77.514 Y74.201 E.0018
G1 X77.2 Y74.2 E.00568
G1 X77.2 Y81.8 E.1376
G1 X77.514 Y81.8 E.00568
G1 X77.553 Y81.672 E.00242
; WIPE_START
G1 F21000
G1 X77.514 Y81.8 E-.05079
G1 X77.2 Y81.8 E-.11922
G1 X77.2 Y80.247 E-.59
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.168 Y81.788 Z6.96 F42000
G1 Z6.56
G1 E.8 F1800
; LINE_WIDTH: 0.419992
G1 F4482
M204 S6000
G1 X84.788 Y81.788 E.06976
G1 X84.787 Y79.526 E.04359
G1 X81.219 Y81.756 E.08109
M204 S10000
G1 X82.543 Y81.393 F42000
G1 F4482
M204 S6000
G1 X84.393 Y81.393 E.03566
G1 X84.393 Y80.237 E.02228
G1 X82.594 Y81.362 E.04089
M204 S10000
G1 X84.008 Y80.935 F42000
; LINE_WIDTH: 0.456172
G1 F4482
M204 S6000
G2 X84.001 Y81.028 I-.027 J.045 E.00451
M204 S10000
G1 X83.135 Y79.629 F42000
; LINE_WIDTH: 0.421016
G1 F4482
M204 S6000
G1 X78.96 Y82.238 E.09516
G3 X79.038 Y82.576 I-.739 J.349 E.00675
G1 X85.154 Y82.576 E.11818
G1 X85.395 Y82.509 E.00485
G1 X85.515 Y82.383 E.00336
G1 X85.576 Y82.071 E.00613
G2 X85.569 Y78.035 I-907.303 J-.445 E.078
G1 X85.475 Y78.17 E.00317
G1 X83.186 Y79.597 E.05213
M204 S10000
G1 X85.181 Y78.815 F42000
; LINE_WIDTH: 0.419992
G1 F4482
M204 S6000
G1 X79.794 Y82.182 E.12245
G1 X85.135 Y82.182 E.10296
G1 X85.182 Y82.071 E.00231
G1 X85.181 Y78.875 E.06161
M204 S10000
G1 X85.181 Y77.185 F42000
G1 F4482
M204 S6000
G1 X85.18 Y73.886 E.06359
G2 X85.105 Y73.82 I-.075 J.01 E.00209
G1 X79.795 Y73.819 E.10236
G1 X85.13 Y77.153 E.12126
M204 S10000
G1 X83.135 Y76.371 F42000
; LINE_WIDTH: 0.420665
G1 F4482
M204 S6000
G1 X85.475 Y77.831 E.05324
G1 X85.571 Y78 E.00375
G2 X85.574 Y73.886 I-1142.693 J-2.976 E.07944
G1 X85.505 Y73.6 E.00567
G1 X85.328 Y73.473 E.00421
G1 X85.105 Y73.426 E.00439
G1 X79.038 Y73.424 E.11715
G1 X78.994 Y73.736 E.00607
G1 X78.96 Y73.762 E.00083
G1 X83.084 Y76.34 E.09391
M204 S10000
G1 X84.007 Y74.973 F42000
; LINE_WIDTH: 0.454312
G1 F4482
M204 S6000
G2 X84 Y75.066 I-.027 J.045 E.00446
M204 S10000
G1 X82.545 Y74.608 F42000
; LINE_WIDTH: 0.419992
G1 F4482
M204 S6000
G1 X84.392 Y75.762 E.04197
G1 X84.391 Y74.608 E.02224
G1 X82.605 Y74.608 E.03443
M204 S10000
G1 X81.17 Y74.213 F42000
G1 F4482
M204 S6000
G1 X84.786 Y76.473 E.0822
G1 X84.786 Y74.214 E.04355
G1 X81.23 Y74.213 E.06853
M204 S10000
G1 X78.347 Y73.942 F42000
G1 F4482
M204 S6000
G1 X78.347 Y73.844 E.00189
G1 X78.126 Y73.762 E.00454
G3 X78.108 Y73.424 I.37 J-.189 E.00671
G1 X76.846 Y73.424 E.02432
G1 X76.605 Y73.491 E.00484
G1 X76.485 Y73.617 E.00335
G1 X76.424 Y73.929 E.00612
G1 X76.424 Y82.154 E.15854
G1 X76.513 Y82.426 E.00552
G1 X76.682 Y82.531 E.00384
G1 X76.929 Y82.576 E.00484
G1 X78.108 Y82.576 E.02273
G3 X78.126 Y82.238 I.389 J-.148 E.00672
G1 X78.347 Y82.156 E.00454
G1 X78.347 Y74.002 E.15717
M204 S10000
G1 X77.953 Y74.086 F42000
G1 F4482
M204 S6000
G1 X77.824 Y74.015 E.00284
G1 X77.768 Y73.818 E.00395
G1 X76.865 Y73.818 E.01741
G1 X76.818 Y73.929 E.00231
G1 X76.818 Y82.135 E.15819
G1 X76.929 Y82.182 E.00231
G1 X77.768 Y82.182 E.01617
G1 X77.824 Y81.985 E.00395
G1 X77.953 Y81.914 E.00284
G1 X77.953 Y74.146 E.14971
M204 S10000
G1 X78.568 Y73.462 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.102093
G1 F4482
M204 S6000
M73 P80 R2
G1 X78.601 Y73.227 E.00089
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X78.568 Y73.462 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 55/73
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z6.96 I-.967 J.739 P1  F42000
G1 X102.535 Y104.84 Z6.96
G1 Z6.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5593
M204 S5000
G1 X102.21 Y104.84 E.00627
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.595 Y104.84 E.00761
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14632
G1 X102.21 Y103.225 E-.61368
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.08 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 55 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer55 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.68
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5593
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.08 F42000
G1 X85.29 Y104.84 Z7.08
G1 Z6.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5593
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5593
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.241 Y87.51 Z7.08 F42000
G1 X79.59 Y80.379 Z7.08
G1 Z6.68
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5593
M204 S5000
G1 X79.59 Y75.621 E.09171
G1 X83.396 Y78 E.08652
G1 X79.641 Y80.347 E.08536
; WIPE_START
G1 F12000
M204 S6000
G1 X79.619 Y78.347 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.628 Y79.605 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5593
M204 S6000
G1 X76.028 Y79.981 E.01468
G1 X76.028 Y76.019 E.08217
G1 X76.628 Y76.395 E.01468
G2 X76.608 Y79.549 I4.323 J1.605 E.06678
; WIPE_START
G1 F21000
G1 X76.028 Y79.981 E-.27464
G1 X76.028 Y78.703 E-.48536
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.663 Y73.95 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
G1 F5593
M204 S6000
G1 X76.028 Y75.17 E.06023
G3 X76.03 Y73.766 I21.545 J-.668 E.02913
G3 X76.834 Y73.028 I.789 J.053 E.02498
G1 X79.674 Y73.028 E.05891
G1 X79.73 Y73.206 E.00388
G1 X78.712 Y73.916 E.02574
; WIPE_START
G1 F21000
G1 X76.9 Y74.763 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.631 Y82.035 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
G1 F5593
M204 S6000
G1 X79.679 Y82.796 E.02688
G1 X79.622 Y82.972 E.00384
G1 X76.834 Y82.972 E.05782
G3 X76.028 Y82.163 I-.011 J-.795 E.02644
G1 X76.028 Y80.83 E.02765
G1 X78.576 Y82.01 E.05824
; WIPE_START
G1 F21000
G1 X79.679 Y82.796 E-.51482
G1 X79.622 Y82.972 E-.07029
G1 X79.162 Y82.972 E-.1749
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.986 Y83.22 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
G1 F5593
M204 S6000
G1 X80.929 Y83.396 E.00384
G1 X76.827 Y83.396 E.08507
G3 X75.604 Y82.171 I-.003 J-1.221 E.03993
G1 X75.604 Y73.827 E.17306
G3 X76.827 Y72.604 I1.221 J-.003 E.03989
G1 X81.025 Y72.604 E.08708
G1 X81.081 Y72.782 E.00388
G1 X78.875 Y74.32 E.05578
G1 X76.137 Y75.587 E.06258
G1 X77.155 Y76.224 E.0249
G2 X77.155 Y79.776 I3.843 J1.776 E.07605
G1 X76.137 Y80.413 E.0249
G1 X78.846 Y81.667 E.06193
G1 X80.937 Y83.185 E.0536
; WIPE_START
G1 F21000
G1 X80.929 Y83.396 E-.08031
G1 X79.14 Y83.396 E-.67969
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.166 Y82.972 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
G1 F5593
M204 S6000
G1 X81.816 Y82.972 E.06949
G1 X81.816 Y82.591 E.00791
G2 X81.816 Y73.409 I-.821 J-4.591 E.26967
G1 X81.816 Y73.028 E.00791
G1 X85.224 Y73.03 E.07071
G3 X85.972 Y73.834 I-.043 J.789 E.02517
G1 X85.972 Y82.166 E.17281
G3 X85.226 Y82.97 I-.795 J.011 E.02513
M204 S10000
G1 X85.173 Y83.396 F42000
G1 F5593
M204 S6000
G1 X81.391 Y83.396 E.07844
G1 X81.391 Y82.216 E.02448
G2 X81.391 Y73.784 I-.39 J-4.216 E.25971
G1 X81.391 Y72.604 E.02448
G1 X85.251 Y72.606 E.08006
G3 X86.396 Y73.827 I-.07 J1.213 E.03831
G1 X86.396 Y82.173 E.1731
G3 X85.233 Y83.395 I-1.221 J.003 E.03865
M204 S250
G1 X85.19 Y83.804 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5593
M204 S5000
G1 X85.179 Y83.805 E.0002
G1 X76.821 Y83.805 E.16112
G3 X75.195 Y82.179 I.005 J-1.631 E.0492
G1 X75.195 Y73.821 E.1611
G3 X76.821 Y72.195 I1.631 J.005 E.04919
G1 X85.276 Y72.198 E.16299
G3 X86.805 Y73.821 I-.095 J1.622 E.04737
G1 X86.805 Y82.179 E.16112
G3 X85.499 Y83.773 I-1.631 J-.005 E.04299
G1 X85.249 Y83.798 E.00484
; WIPE_START
G1 F12000
M204 S6000
G1 X85.179 Y83.805 E-.0268
G1 X83.25 Y83.805 E-.7332
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.784 Y82.227 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F5593
M204 S6000
G1 X83.858 Y82.558 E.00654
G1 X85.218 Y82.555 E.02621
G1 X85.405 Y82.478 E.0039
G1 X85.538 Y82.291 E.00442
G2 X85.562 Y80.859 I-27.517 J-1.185 E.02761
G1 X85.235 Y80.786 E.00647
G1 X84.848 Y81.3 E.0124
G1 X84.157 Y81.966 E.01851
G1 X83.833 Y82.193 E.00762
M204 S10000
G1 X84.507 Y82.169 F42000
; LINE_WIDTH: 0.408112
G1 F5593
M204 S6000
G1 X85.14 Y82.167 E.01185
G1 X85.174 Y82.098 E.00144
G1 X85.174 Y81.512 E.01095
G1 X84.549 Y82.127 E.01638
M204 S10000
G1 X83.429 Y82.513 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.388659
G1 F5593
M204 S6000
G1 X82.335 Y82.76 E.01989
M204 S10000
G1 X82.377 Y82.716 F42000
; LINE_WIDTH: 0.13504
G1 F5593
M204 S6000
G1 X82.523 Y82.696 E.00079
; LINE_WIDTH: 0.175852
G1 X82.65 Y82.673 E.00094
; LINE_WIDTH: 0.220099
G1 X82.771 Y82.652 E.00117
; LINE_WIDTH: 0.263454
G1 X82.892 Y82.63 E.00143
; LINE_WIDTH: 0.286646
G1 X83.432 Y82.525 E.00701
M204 S10000
G1 X82.377 Y82.716 F42000
; LINE_WIDTH: 0.0981762
G1 F5593
M204 S6000
G1 X82.23 Y82.736 E.00052
; WIPE_START
G1 F21000
G1 X82.377 Y82.716 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.164 Y83.409 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.098618
G1 F5593
M204 S6000
G1 X81.133 Y83.601 E.00069
; WIPE_START
G1 F21000
G1 X81.164 Y83.409 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.414 Y82.386 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F5593
M204 S6000
G1 X76.441 Y81.472 E.04191
G1 X76.45 Y82.252 E.01503
G2 X76.651 Y82.515 I.368 J-.072 E.00662
G1 X76.91 Y82.563 E.00509
G1 X78.661 Y82.563 E.03374
G1 X78.463 Y82.421 E.0047
M204 S10000
G1 X76.897 Y82.085 F42000
; LINE_WIDTH: 0.471992
G1 F5593
M204 S6000
G2 X76.892 Y82.181 I-.028 J.047 E.00493
; WIPE_START
G1 F21000
G1 X76.841 Y82.181 E-.17903
G1 X76.813 Y82.133 E-.19366
G1 X76.841 Y82.085 E-.19366
G1 X76.897 Y82.085 E-.19365
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.309 Y79.555 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.131445
G1 F5593
M204 S6000
G1 X76.291 Y79.432 E.00064
; LINE_WIDTH: 0.0973147
G1 X76.264 Y79.234 E.0007
M204 S10000
G1 X76.264 Y76.77 F42000
; LINE_WIDTH: 0.0959337
G1 F5593
M204 S6000
G1 X76.286 Y76.607 E.00056
; LINE_WIDTH: 0.128297
G1 X76.309 Y76.445 E.00082
; WIPE_START
G1 F21000
G1 X76.286 Y76.607 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.458 Y73.594 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F5593
M204 S6000
G1 X78.683 Y73.437 E.00528
G1 X76.852 Y73.437 E.03529
G1 X76.596 Y73.519 E.00519
G1 X76.47 Y73.682 E.00396
G1 X76.437 Y73.898 E.00422
G1 X76.437 Y74.53 E.01217
G1 X78.404 Y73.619 E.04177
; WIPE_START
G1 F21000
G1 X76.589 Y74.46 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.23 Y73.264 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0981894
G1 F5593
M204 S6000
G1 X82.377 Y73.284 E.00052
; LINE_WIDTH: 0.135064
G1 X82.523 Y73.304 E.00079
; LINE_WIDTH: 0.177014
G1 X82.656 Y73.328 E.001
; LINE_WIDTH: 0.223529
G1 X82.784 Y73.351 E.00125
; LINE_WIDTH: 0.269154
G1 X82.912 Y73.373 E.00154
; LINE_WIDTH: 0.294092
G1 X83.435 Y73.478 E.007
M204 S10000
G1 X85.227 Y75.216 F42000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F5593
M204 S6000
G1 X85.561 Y75.141 E.00659
G1 X85.56 Y73.895 E.02403
G1 X85.488 Y73.604 E.00578
G1 X85.335 Y73.492 E.00366
G1 X85.098 Y73.439 E.00469
G1 X83.86 Y73.439 E.02385
G1 X83.792 Y73.778 E.00667
G3 X85.193 Y75.167 I-2.413 J3.834 E.03833
M204 S10000
G1 X85.176 Y74.502 F42000
; LINE_WIDTH: 0.400532
G1 F5593
M204 S6000
G1 X85.176 Y73.895 E.01113
G1 X85.121 Y73.827 E.00159
G1 X84.498 Y73.823 E.01142
G3 X85.136 Y74.457 I-2.535 J3.191 E.01651
M204 S10000
G1 X85.513 Y75.571 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.386374
G1 F5593
M204 S6000
G1 X85.76 Y76.669 E.01984
M204 S10000
G1 X85.727 Y76.691 F42000
; LINE_WIDTH: 0.0853771
G1 F5593
M204 S6000
G1 X85.736 Y76.766 E.00022
M204 S10000
G1 X85.727 Y76.691 F42000
; LINE_WIDTH: 0.108487
G1 F5593
M204 S6000
G1 X85.71 Y76.574 E.00048
; LINE_WIDTH: 0.14364
G1 X85.692 Y76.453 E.0007
; LINE_WIDTH: 0.182181
G1 X85.671 Y76.338 E.00089
; LINE_WIDTH: 0.223273
G1 X85.651 Y76.223 E.00113
; LINE_WIDTH: 0.282546
G2 X85.525 Y75.568 I-21.283 J3.741 E.00838
; WIPE_START
G1 F21000
G1 X85.651 Y76.223 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.647 Y76.351 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F5593
M204 S2000
G1 X82.653 Y74.357 E.05436
G1 X81.822 Y74.083
G1 X84.917 Y77.178 E.08439
G1 X84.997 Y77.815
G1 X81.185 Y74.003 E.10391
G1 X81.159 Y73.978
G1 X80.589 Y73.408 E.01554
G1 X80.261 Y73.637
G1 X84.986 Y78.362 E.12881
G1 X84.912 Y78.846
G1 X79.932 Y73.866 E.13576
M73 P81 R2
G1 X79.604 Y74.095
G1 X83.015 Y77.506 E.09299
; WIPE_START
G1 F12000
M204 S6000
G1 X81.601 Y76.092 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.528 Y76.577 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
G1 F5593
M204 S2000
G1 X79.275 Y74.324 E.06142
G1 X78.939 Y74.545
G1 X80.041 Y75.647 E.03004
G1 X79.373 Y75.537
G1 X78.558 Y74.722 E.02222
G1 X78.177 Y74.898
G1 X79.373 Y76.094 E.03261
G1 X79.373 Y76.652
G1 X77.796 Y75.075 E.043
G1 X77.415 Y75.251
G1 X79.373 Y77.21 E.05338
G1 X79.373 Y77.767
G1 X77.034 Y75.428 E.06377
G1 X77.367 Y76.318
G1 X79.373 Y78.325 E.05469
G1 X79.373 Y78.882
G1 X77.209 Y76.718 E.05901
G1 X77.088 Y77.154
G1 X79.373 Y79.44 E.0623
G1 X79.373 Y79.997
G1 X77.014 Y77.638 E.06432
G1 X77.003 Y78.185
G1 X79.373 Y80.555 E.0646
; WIPE_START
G1 F12000
M204 S6000
G1 X77.959 Y79.141 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.623 Y78.114 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
G1 F5593
M204 S2000
G1 X84.791 Y79.283 E.03185
G1 X84.633 Y79.682
G1 X83.28 Y78.328 E.03689
G1 X82.937 Y78.543
G1 X84.439 Y80.045 E.04095
G1 X84.216 Y80.38
G1 X82.594 Y78.757 E.04423
G1 X82.25 Y78.972
G1 X83.965 Y80.686 E.04674
G1 X83.687 Y80.966
G1 X81.907 Y79.186 E.04852
G1 X81.564 Y79.401
G1 X83.38 Y81.216 E.04949
G1 X83.045 Y81.439
G1 X81.221 Y79.615 E.04972
G1 X80.878 Y79.83
G1 X82.682 Y81.633 E.04916
G1 X82.282 Y81.791
G1 X80.535 Y80.044 E.04763
G1 X80.192 Y80.258
G1 X81.846 Y81.912 E.04508
G1 X81.362 Y81.986
G1 X79.849 Y80.473 E.04125
G1 X79.506 Y80.687
G1 X81.159 Y82.341 E.04508
G1 X81.159 Y82.899
G1 X77.083 Y78.822 E.11113
G1 X77.353 Y79.65
G1 X79.713 Y82.01 E.06433
M204 S10000
G1 X78.308 Y81.162 F42000
G1 F5593
M204 S2000
G1 X77.18 Y80.034 E.03075
; WIPE_START
G1 F12000
M204 S6000
G1 X78.308 Y81.162 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.393 Y75.78 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0751392
G1 F5593
M204 S6000
G1 X79.279 Y75.721 E.00031
; WIPE_START
G1 F21000
G1 X79.393 Y75.78 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.701 Y76.058 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.0972575
G1 F5593
M204 S6000
G1 X80.502 Y75.9 E.00089
; LINE_WIDTH: 0.145652
G1 X80.304 Y75.742 E.00149
; LINE_WIDTH: 0.194046
G1 X80.105 Y75.584 E.00209
; WIPE_START
G1 F21000
G1 X80.304 Y75.742 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.188 Y76.988 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.0972595
G1 F5593
M204 S6000
G1 X81.989 Y76.829 E.00089
; LINE_WIDTH: 0.145658
G1 X81.79 Y76.671 E.00149
; LINE_WIDTH: 0.194057
G1 X81.591 Y76.513 E.00209
; WIPE_START
G1 F21000
G1 X81.79 Y76.671 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.818 Y76.761 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.19995
G1 F5593
M204 S6000
G1 X84.582 Y76.416 E.00356
M204 S10000
G1 X84.18 Y75.574 F42000
; LINE_WIDTH: 0.0936278
G1 F5593
M204 S6000
G2 X83.427 Y74.821 I-7 J6.247 E.00353
; WIPE_START
G1 F21000
G1 X83.824 Y75.191 E-.38731
G1 X84.18 Y75.574 E-.37269
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.297 Y80.436 Z7.08 F42000
G1 X77.738 Y80.898 Z7.08
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.0959394
G1 F5593
M204 S6000
G1 X77.604 Y80.805 E.00056
; LINE_WIDTH: 0.141712
G1 X77.471 Y80.712 E.00092
; LINE_WIDTH: 0.187484
G1 X77.337 Y80.619 E.00129
; LINE_WIDTH: 0.233257
G1 X77.204 Y80.526 E.00165
; LINE_WIDTH: 0.279029
G1 X77.071 Y80.433 E.00202
; LINE_WIDTH: 0.324802
G1 X76.937 Y80.34 E.00238
; LINE_WIDTH: 0.370574
G1 X76.804 Y80.246 E.00274
M204 S10000
G1 X78.776 Y81.379 F42000
; LINE_WIDTH: 0.0950453
G1 F5593
M204 S6000
G1 X78.642 Y81.285 E.00056
; LINE_WIDTH: 0.139029
G1 X78.507 Y81.192 E.00091
; LINE_WIDTH: 0.183012
G1 X78.373 Y81.098 E.00126
; WIPE_START
G1 F21000
G1 X78.507 Y81.192 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.675 Y77.917 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.0972594
G1 F5593
M204 S6000
G1 X83.476 Y77.759 E.00089
; LINE_WIDTH: 0.145658
G1 X83.277 Y77.601 E.00149
; LINE_WIDTH: 0.194057
G1 X83.078 Y77.442 E.00209
; WIPE_START
G1 F21000
G1 X83.277 Y77.601 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.607 Y82.656 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.092118
G1 F5593
M204 S6000
G1 X80.4 Y82.479 E.00089
; LINE_WIDTH: 0.130254
G1 X80.192 Y82.301 E.0014
; LINE_WIDTH: 0.16839
G1 X79.984 Y82.124 E.00191
; LINE_WIDTH: 0.206527
G1 X79.776 Y81.946 E.00242
; WIPE_START
G1 F21000
G1 X79.984 Y82.124 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.513 Y80.429 Z7.08 F42000
G1 Z6.68
G1 E.8 F1800
; LINE_WIDTH: 0.386276
G1 F5593
M204 S6000
G1 X85.76 Y79.332 E.0198
M204 S10000
G1 X85.716 Y79.377 F42000
; LINE_WIDTH: 0.135023
G1 F5593
M204 S6000
G1 X85.696 Y79.523 E.00079
; LINE_WIDTH: 0.175768
G1 X85.673 Y79.649 E.00094
; LINE_WIDTH: 0.219925
G1 X85.652 Y79.77 E.00117
; LINE_WIDTH: 0.263186
G1 X85.63 Y79.891 E.00143
; LINE_WIDTH: 0.286315
G1 X85.526 Y80.432 E.00701
M204 S10000
G1 X85.716 Y79.377 F42000
; LINE_WIDTH: 0.0981757
G1 F5593
M204 S6000
G1 X85.736 Y79.23 E.00052
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X85.716 Y79.377 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 56/73
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.08 I-1.015 J.671 P1  F42000
G1 X102.535 Y104.84 Z7.08
G1 Z6.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5640
M204 S5000
G1 X102.21 Y104.84 E.00626
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.595 Y104.84 E.00762
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14616
G1 X102.21 Y103.225 E-.61384
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 56 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer56 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5640
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.2 F42000
G1 X85.29 Y104.84 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5640
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F5640
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.547 Y87.404 Z7.2 F42000
G1 X80.487 Y81.047 Z7.2
G1 Z6.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5640
M204 S5000
G1 X80.398 Y81.025 E.00177
G3 X80.759 Y74.915 I.602 J-3.03 E.17073
G1 X80.997 Y74.906 E.00458
G3 X80.755 Y81.074 I.003 J3.089 E.19187
G1 X80.547 Y81.053 E.00403
; WIPE_START
G1 F12000
M204 S6000
G1 X80.398 Y81.025 E-.05758
G1 X80.044 Y80.943 E-.1381
G1 X79.816 Y80.858 E-.09251
G1 X79.589 Y80.754 E-.09478
G1 X79.279 Y80.571 E-.13658
G1 X78.989 Y80.351 E-.13837
G1 X78.812 Y80.188 E-.09164
G1 X78.794 Y80.168 E-.01043
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.22 Y74.905 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5640
M204 S6000
G1 X76.042 Y74.849 E.00388
G3 X76.044 Y73.773 I16.319 J-.504 E.02232
G3 X76.841 Y73.042 I.782 J.053 E.02476
G1 X77.849 Y73.042 E.02091
G1 X77.905 Y73.22 E.00388
G2 X76.253 Y74.855 I3.317 J5.002 E.04851
; WIPE_START
G1 F21000
G1 X76.042 Y74.849 E-.08046
G1 X76.044 Y73.773 E-.40877
G1 X76.069 Y73.621 E-.05839
G1 X76.123 Y73.478 E-.05813
G1 X76.205 Y73.346 E-.05924
G1 X76.309 Y73.236 E-.05726
G1 X76.389 Y73.178 E-.03774
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.845 Y76.92 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S6000
G1 X75.617 Y76.896 E.00474
G1 X75.617 Y73.834 E.0635
G3 X76.834 Y72.617 I1.214 J-.003 E.03967
G1 X79.896 Y72.617 E.0635
G1 X79.92 Y72.845 E.00474
G2 X75.857 Y76.862 I1.094 J5.17 E.12521
; WIPE_START
G1 F21000
G1 X75.617 Y76.896 E-.09206
G1 X75.617 Y75.138 E-.66794
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.248 Y74.963 Z7.2 F42000
G1 X85.78 Y74.905 Z7.2
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S6000
G2 X84.095 Y73.22 I-5.002 J3.317 E.04976
G1 X84.151 Y73.042 E.00388
G3 X85.219 Y73.044 I.504 J16.374 E.02216
G3 X85.958 Y73.841 I-.045 J.783 E.02492
G1 X85.958 Y74.849 E.0209
G1 X85.837 Y74.887 E.00263
; WIPE_START
G1 F21000
G1 X85.471 Y74.476 E-.20922
G1 X85.025 Y73.975 E-.25485
G1 X84.524 Y73.53 E-.25474
G1 X84.436 Y73.466 E-.04119
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.156 Y76.92 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S6000
G2 X82.077 Y72.844 I-5.17 J1.094 E.12651
G1 X82.102 Y72.617 E.00473
G1 X85.246 Y72.62 E.06522
G3 X86.383 Y73.834 I-.072 J1.206 E.03804
G1 X86.383 Y76.896 E.0635
M73 P82 R2
G1 X86.215 Y76.914 E.00349
; WIPE_START
G1 F21000
G1 X86.07 Y76.57 E-.14172
G1 X85.944 Y76.18 E-.156
G1 X85.784 Y75.795 E-.15834
G1 X85.607 Y75.445 E-.14884
G1 X85.388 Y75.101 E-.15511
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.166 Y82.73 Z7.2 F42000
G1 X85.159 Y82.958 Z7.2
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S6000
G1 X84.151 Y82.958 E.0209
G1 X84.095 Y82.78 E.00388
G2 X85.78 Y81.095 I-3.317 J-5.002 E.04976
G1 X85.958 Y81.151 E.00388
G3 X85.956 Y82.227 I-16.32 J.504 E.02232
G3 X85.219 Y82.957 I-.782 J-.053 E.02352
M204 S10000
G1 X85.166 Y83.383 F42000
G1 F5640
M204 S6000
G1 X82.105 Y83.383 E.0635
G1 X82.08 Y83.156 E.00474
G2 X86.156 Y79.08 I-1.094 J-5.17 E.12645
G1 X86.383 Y79.105 E.00474
G1 X86.383 Y82.166 E.0635
G3 X85.226 Y83.381 I-1.214 J.003 E.03843
; WIPE_START
G1 F21000
G1 X83.226 Y83.382 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.905 Y82.78 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S6000
G1 X77.849 Y82.958 E.00388
G3 X76.773 Y82.956 I-.504 J-16.424 E.02232
G3 X76.042 Y82.159 I.053 J-.783 E.02476
G1 X76.042 Y81.151 E.0209
G1 X76.22 Y81.095 E.00388
G1 X76.395 Y81.346 E.00633
G2 X77.855 Y82.747 I4.7 J-3.436 E.0422
; WIPE_START
G1 F21000
G1 X77.849 Y82.958 E-.08035
G1 X76.773 Y82.956 E-.40884
G1 X76.622 Y82.931 E-.05827
G1 X76.478 Y82.877 E-.05822
G1 X76.346 Y82.795 E-.05925
G1 X76.236 Y82.691 E-.05727
G1 X76.178 Y82.611 E-.0378
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.923 Y83.156 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S6000
G1 X79.898 Y83.383 E.00473
G1 X76.834 Y83.383 E.06355
G3 X75.617 Y82.166 I-.003 J-1.214 E.03967
G1 X75.617 Y79.104 E.0635
G1 X75.844 Y79.08 E.00474
G1 X75.877 Y79.23 E.00319
G2 X79.864 Y83.143 I5.125 J-1.233 E.12213
; WIPE_START
G1 F21000
G1 X79.898 Y83.383 E-.09177
G1 X78.139 Y83.383 E-.66823
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.185 Y83.791 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5640
M204 S5000
G1 X85.173 Y83.792 E.00023
G1 X76.828 Y83.792 E.16086
G3 X75.208 Y82.173 I.005 J-1.625 E.04899
G1 X75.208 Y73.828 E.16086
G3 X76.828 Y72.208 I1.625 J.005 E.04899
G1 X85.272 Y72.211 E.16277
G3 X86.792 Y73.828 I-.098 J1.615 E.04712
G1 X86.792 Y82.173 E.16086
G3 X85.491 Y83.759 I-1.625 J-.005 E.04281
G1 X85.244 Y83.785 E.00478
; WIPE_START
G1 F12000
M204 S6000
G1 X85.173 Y83.792 E-.02741
G1 X83.245 Y83.792 E-.73259
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.596 Y82.746 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.489067
G1 F5640
M204 S6000
G1 X85.164 Y82.511 E.01393
; LINE_WIDTH: 0.514584
G1 X85.218 Y82.488 E.00141
; LINE_WIDTH: 0.546593
G1 X85.254 Y82.468 E.00105
; LINE_WIDTH: 0.581092
G2 X85.448 Y82.288 I-.263 J-.477 E.00728
G1 X85.478 Y82.236 E.00161
; LINE_WIDTH: 0.532277
G1 X85.499 Y82.193 E.0012
; LINE_WIDTH: 0.49139
G1 X85.746 Y81.575 E.01515
M204 S10000
G1 X85.956 Y80.928 F42000
; LINE_WIDTH: 0.135844
G1 F5640
M204 S6000
G1 X86.116 Y80.114 E.00447
; LINE_WIDTH: 0.121456
G1 X86.132 Y80.026 E.00042
; LINE_WIDTH: 0.0936535
G1 X86.148 Y79.938 E.0003
M204 S10000
G1 X86.156 Y79.94 F42000
; LINE_WIDTH: 0.228702
G1 F5640
M204 S6000
G1 X85.941 Y80.923 E.00999
M204 S10000
G1 X85.931 Y80.92 F42000
; LINE_WIDTH: 0.329735
G1 F5640
M204 S6000
G1 X86.166 Y79.942 E.01496
; WIPE_START
G1 F21000
G1 X85.931 Y80.92 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.991 Y78.856 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.569242
G1 F5640
M204 S6000
G1 X86.308 Y78.609 E.01066
G1 X86.325 Y78.005 E.01606
G1 X86.308 Y77.391 E.01634
G1 X85.992 Y77.144 E.01065
; WIPE_START
G1 F19319.574
G1 X86.308 Y77.391 E-.15236
G1 X86.325 Y78.005 E-.2336
G1 X86.308 Y78.609 E-.2297
G1 X86.008 Y78.843 E-.14434
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.165 Y76.057 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.329815
G1 F5640
M204 S6000
G1 X85.932 Y75.08 E.01494
M204 S10000
G1 X85.941 Y75.077 F42000
; LINE_WIDTH: 0.228681
G1 F5640
M204 S6000
G1 X86.156 Y76.059 E.00998
M204 S10000
G1 X86.148 Y76.06 F42000
; LINE_WIDTH: 0.0940352
G1 F5640
M204 S6000
G1 X86.132 Y75.971 E.0003
; LINE_WIDTH: 0.135883
G2 X85.956 Y75.072 I-60.944 J11.454 E.00493
; WIPE_START
G1 F21000
G1 X86.132 Y75.971 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.213 Y73.256 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.543873
G1 F5640
M204 S6000
G1 X85.49 Y73.787 E.01517
; LINE_WIDTH: 0.498179
G3 X85.744 Y74.429 I-9.875 J4.272 E.01594
M204 S10000
G1 X85.745 Y74.107 F42000
; LINE_WIDTH: 0.585741
G1 F5640
M204 S6000
G2 X85.364 Y73.611 I-2.71 J1.688 E.01716
G1 X85.237 Y73.522 E.00424
; LINE_WIDTH: 0.525173
G1 X85.173 Y73.493 E.00174
; LINE_WIDTH: 0.497187
G1 X84.571 Y73.257 E.01489
M204 S10000
G1 X83.928 Y73.045 F42000
; LINE_WIDTH: 0.137325
G1 F5640
M204 S6000
G1 X83.117 Y72.885 E.00451
; LINE_WIDTH: 0.1226
G1 X83.029 Y72.868 E.00043
; LINE_WIDTH: 0.0940348
G1 X82.94 Y72.852 E.0003
M204 S10000
G1 X82.941 Y72.844 F42000
; LINE_WIDTH: 0.228763
G1 F5640
M204 S6000
G1 X83.923 Y73.06 E.00998
M204 S10000
G1 X83.92 Y73.069 F42000
; LINE_WIDTH: 0.329741
G1 F5640
M204 S6000
G1 X82.943 Y72.834 E.01494
; WIPE_START
G1 F21000
G1 X83.92 Y73.069 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.853 Y73.004 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.539855
G1 F5640
M204 S6000
G1 X81.621 Y72.71 E.00942
; LINE_WIDTH: 0.562006
G1 X81.607 Y72.692 E.00059
G1 X80.982 Y72.675 E.01639
G1 X80.391 Y72.692 E.01551
G1 X80.379 Y72.707 E.0005
; LINE_WIDTH: 0.545158
G1 X80.143 Y73.004 E.00962
; WIPE_START
G1 F20215.427
G1 X80.379 Y72.707 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.057 Y72.834 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.329715
G1 F5640
M204 S6000
G1 X78.08 Y73.069 E.01494
M204 S10000
G1 X78.077 Y73.059 F42000
; LINE_WIDTH: 0.228799
G1 F5640
M204 S6000
G1 X79.059 Y72.844 E.00998
M204 S10000
G1 X79.06 Y72.852 F42000
; LINE_WIDTH: 0.0940145
G1 F5640
M204 S6000
G1 X78.972 Y72.868 E.0003
; LINE_WIDTH: 0.135819
G2 X78.073 Y73.047 I7.731 J41.216 E.00493
M204 S10000
G1 X77.405 Y73.254 F42000
; LINE_WIDTH: 0.489336
G1 F5640
M204 S6000
G1 X76.827 Y73.493 E.01418
; LINE_WIDTH: 0.518098
G1 X76.782 Y73.512 E.00117
; LINE_WIDTH: 0.559858
G2 X76.699 Y73.56 I.374 J.744 E.0025
; LINE_WIDTH: 0.583317
G2 X76.522 Y73.764 I.318 J.457 E.00744
; LINE_WIDTH: 0.52534
G1 X76.493 Y73.827 E.0017
; LINE_WIDTH: 0.490733
G1 X76.254 Y74.425 E.01464
M204 S10000
G1 X76.046 Y75.073 F42000
; LINE_WIDTH: 0.135871
G1 F5640
M204 S6000
G1 X75.884 Y75.886 E.00447
; LINE_WIDTH: 0.121489
G1 X75.868 Y75.974 E.00042
; LINE_WIDTH: 0.0936646
G1 X75.852 Y76.062 E.0003
M204 S10000
G1 X75.844 Y76.06 F42000
; LINE_WIDTH: 0.228631
G1 F5640
M204 S6000
G1 X76.06 Y75.077 E.00999
M204 S10000
G1 X76.069 Y75.08 F42000
; LINE_WIDTH: 0.329882
G1 F5640
M204 S6000
G1 X75.833 Y76.058 E.01497
; WIPE_START
G1 F21000
G1 X76.069 Y75.08 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.008 Y77.144 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.566472
G1 F5640
M204 S6000
G1 X75.692 Y77.391 E.0106
G1 X75.677 Y78.204 E.02151
G1 X75.692 Y78.609 E.01072
G1 X75.706 Y78.621 E.00049
; LINE_WIDTH: 0.545984
G1 X76.004 Y78.857 E.00965
; WIPE_START
G1 F20183.329
G1 X75.706 Y78.621 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.834 Y79.943 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.329683
G1 F5640
M204 S6000
G1 X76.069 Y80.92 E.01494
M204 S10000
G1 X76.059 Y80.923 F42000
; LINE_WIDTH: 0.2287
G1 F5640
M204 S6000
G1 X75.844 Y79.941 E.00998
M204 S10000
G1 X75.852 Y79.94 F42000
; LINE_WIDTH: 0.094037
G1 F5640
M204 S6000
G1 X75.868 Y80.029 E.0003
; LINE_WIDTH: 0.12262
G1 X75.885 Y80.118 E.00043
; LINE_WIDTH: 0.137356
G1 X76.048 Y80.927 E.0045
M204 S10000
G1 X76.257 Y81.571 F42000
; LINE_WIDTH: 0.497085
G1 F5640
M204 S6000
G1 X76.493 Y82.173 E.01489
; LINE_WIDTH: 0.526281
G1 X76.524 Y82.24 E.00181
; LINE_WIDTH: 0.579778
G2 X76.713 Y82.449 I.509 J-.271 E.0077
G1 X76.764 Y82.478 E.0016
; LINE_WIDTH: 0.5323
G1 X76.807 Y82.499 E.00119
; LINE_WIDTH: 0.491331
G1 X77.424 Y82.746 E.01514
M204 S10000
G1 X78.073 Y82.952 F42000
; LINE_WIDTH: 0.135871
G1 F5640
M204 S6000
G2 X78.971 Y83.132 I7.54 J-35.27 E.00493
; LINE_WIDTH: 0.0940395
G1 X79.06 Y83.148 E.0003
M204 S10000
G1 X79.059 Y83.155 F42000
; LINE_WIDTH: 0.228668
G1 F5640
M204 S6000
G1 X78.077 Y82.941 E.00998
M204 S10000
G1 X78.08 Y82.931 F42000
; LINE_WIDTH: 0.329806
G1 F5640
M204 S6000
G1 X79.057 Y83.166 E.01494
; WIPE_START
G1 F21000
G1 X78.08 Y82.931 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.147 Y82.996 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.539855
G1 F5640
M204 S6000
G1 X80.379 Y83.29 E.00942
; LINE_WIDTH: 0.561949
G1 X80.393 Y83.308 E.00059
G1 X80.995 Y83.325 E.01578
G1 X81.609 Y83.308 E.01612
G1 X81.621 Y83.293 E.00049
; LINE_WIDTH: 0.545259
G1 X81.857 Y82.996 E.00963
; WIPE_START
G1 F20211.469
G1 X81.621 Y83.293 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.928 Y82.955 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.137223
G1 F5640
M204 S6000
G1 X83.117 Y83.115 E.0045
; LINE_WIDTH: 0.12253
G1 X83.028 Y83.132 E.00043
; LINE_WIDTH: 0.0940065
G1 X82.94 Y83.148 E.0003
M204 S10000
G1 X82.941 Y83.155 F42000
; LINE_WIDTH: 0.228823
G1 F5640
M204 S6000
G1 X83.923 Y82.941 E.00998
M204 S10000
G1 X83.92 Y82.931 F42000
; LINE_WIDTH: 0.329796
G1 F5640
M204 S6000
G1 X82.943 Y83.166 E.01494
M204 S10000
G1 X82.657 Y82.755 F42000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F5640
M204 S2000
G1 X85.755 Y79.657 E.08445
G1 X85.954 Y78.9
G1 X81.9 Y82.954 E.11052
G1 X81.268 Y83.028
G1 X86.028 Y78.268 E.12975
G1 X86.027 Y77.712
G1 X80.712 Y83.027 E.14489
G1 X80.208 Y82.973
G1 X82.038 Y81.143 E.04989
G1 X81.332 Y81.292
G1 X79.747 Y82.877 E.04319
G1 X79.32 Y82.747
G1 X80.765 Y81.302 E.03939
G1 X80.278 Y81.23
G1 X78.922 Y82.587 E.03698
G1 X78.551 Y82.4
G1 X79.849 Y81.102 E.03539
G1 X79.463 Y80.931
G1 X78.205 Y82.189 E.03429
G1 X77.882 Y81.955
G1 X79.116 Y80.721 E.03364
G1 X78.804 Y80.475
G1 X77.581 Y81.698 E.03333
G1 X77.302 Y81.419
G1 X78.525 Y80.196 E.03333
G1 X78.279 Y79.884
G1 X77.046 Y81.118 E.03363
G1 X76.811 Y80.795
G1 X78.07 Y79.536 E.03432
G1 X77.898 Y79.151
G1 X76.6 Y80.449 E.03539
G1 X76.413 Y80.078
G1 X77.77 Y78.721 E.037
G1 X77.698 Y78.235
G1 X76.253 Y79.68 E.03938
G1 X76.123 Y79.253
G1 X77.706 Y77.669 E.04316
G1 X77.857 Y76.962
G1 X76.027 Y78.792 E.04989
; WIPE_START
G1 F12000
M204 S6000
G1 X77.441 Y77.378 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.144 Y79.038 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S2000
G1 X85.973 Y77.208 E.04988
G1 X85.877 Y76.747
G1 X84.292 Y78.332 E.04319
G1 X84.302 Y77.765
G1 X85.747 Y76.32 E.03939
G1 X85.587 Y75.922
G1 X84.23 Y77.279 E.037
G1 X84.102 Y76.849
G1 X85.4 Y75.551 E.03539
G1 X85.189 Y75.205
G1 X83.93 Y76.463 E.03432
G1 X83.721 Y76.116
G1 X84.955 Y74.882 E.03364
G1 X84.698 Y74.581
G1 X83.475 Y75.804 E.03333
G1 X83.196 Y75.525
G1 X84.419 Y74.302 E.03333
G1 X84.118 Y74.045
G1 X82.884 Y75.279 E.03364
G1 X82.537 Y75.069
G1 X83.795 Y73.811 E.03429
G1 X83.449 Y73.6
G1 X82.151 Y74.898 E.0354
G1 X81.722 Y74.77
G1 X83.078 Y73.413 E.03698
G1 X82.68 Y73.253
G1 X81.235 Y74.698 E.03939
G1 X80.67 Y74.706
G1 X82.253 Y73.123 E.04316
G1 X81.792 Y73.027
G1 X79.962 Y74.857 E.04989
; WIPE_START
G1 F12000
M204 S6000
G1 X81.376 Y73.442 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.288 Y72.973 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
G1 F5640
M204 S2000
G1 X75.973 Y78.288 E.14488
G1 X75.972 Y77.731
G1 X80.731 Y72.972 E.12975
G1 X80.1 Y73.046
G1 X76.046 Y77.1 E.11051
G1 X76.245 Y76.343
M73 P83 R2
G1 X79.343 Y73.245 E.08445
; WIPE_START
G1 F12000
M204 S6000
G1 X77.929 Y74.659 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.033 Y76.535 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0828518
G1 F5640
M204 S6000
G1 X77.982 Y76.605 E.00024
; LINE_WIDTH: 0.105799
G1 X77.943 Y76.663 E.00027
; LINE_WIDTH: 0.141859
G2 X77.789 Y76.894 I7.358 J5.064 E.00158
; WIPE_START
G1 F21000
G1 X77.943 Y76.663 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.465 Y80.967 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.0821376
G1 F5640
M204 S6000
G1 X82.398 Y81.016 E.00023
; LINE_WIDTH: 0.104652
G1 X82.339 Y81.056 E.00028
; LINE_WIDTH: 0.141486
G3 X82.106 Y81.211 I-4.94 J-7.166 E.00159
; WIPE_START
G1 F21000
G1 X82.339 Y81.056 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.008 Y76.664 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.089277
G1 F5640
M204 S6000
G1 X84.019 Y76.603 E.00019
G1 X83.96 Y76.522 E.00031
; WIPE_START
G1 F21000
G1 X84.019 Y76.603 E-.46794
G1 X84.008 Y76.664 E-.29206
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.321 Y77.467 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.0836086
G1 F5640
M204 S6000
G1 X84.234 Y77.308 E.00051
; WIPE_START
G1 F21000
G1 X84.321 Y77.467 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.365 Y78.404 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.135209
G1 F5640
M204 S6000
G1 X84.246 Y78.636 E.0014
M204 S10000
G1 X84.211 Y79.106 F42000
; LINE_WIDTH: 0.145177
G1 F5640
M204 S6000
G1 X84.096 Y79.28 E.00122
; LINE_WIDTH: 0.131528
G1 X84.057 Y79.337 E.00036
; LINE_WIDTH: 0.0930207
G1 X83.967 Y79.465 E.00051
; WIPE_START
G1 F21000
G1 X84.057 Y79.337 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.539 Y80.179 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.0891457
G1 F5640
M204 S6000
G1 X85.469 Y80.277 E.00037
; LINE_WIDTH: 0.119801
G1 X85.41 Y80.357 E.00046
; LINE_WIDTH: 0.148912
G1 X85.351 Y80.437 E.0006
; LINE_WIDTH: 0.176008
G1 X85.291 Y80.515 E.00072
; LINE_WIDTH: 0.201071
G1 X85.231 Y80.593 E.00084
; LINE_WIDTH: 0.23467
G1 X85.108 Y80.745 E.002
; LINE_WIDTH: 0.272882
G1 X84.984 Y80.894 E.00235
; LINE_WIDTH: 0.314708
G3 X84.727 Y81.183 I-7.491 J-6.397 E.00546
; LINE_WIDTH: 0.341239
G3 X84.04 Y81.856 I-7.483 J-6.945 E.01484
; LINE_WIDTH: 0.303375
G1 X83.894 Y81.983 E.00262
; LINE_WIDTH: 0.272927
G1 X83.745 Y82.108 E.00235
; LINE_WIDTH: 0.234691
G1 X83.593 Y82.231 E.002
; LINE_WIDTH: 0.201051
G1 X83.515 Y82.291 E.00085
; LINE_WIDTH: 0.175939
G1 X83.436 Y82.351 E.00072
; LINE_WIDTH: 0.148857
G1 X83.357 Y82.41 E.0006
; LINE_WIDTH: 0.119782
G1 X83.277 Y82.469 E.00046
; LINE_WIDTH: 0.0891468
G1 X83.179 Y82.539 E.00037
; WIPE_START
G1 F21000
G1 X83.277 Y82.469 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.893 Y75.628 Z7.2 F42000
G1 X78.821 Y73.461 Z7.2
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.0890931
G1 F5640
M204 S6000
G1 X78.723 Y73.531 E.00037
; LINE_WIDTH: 0.119658
G1 X78.643 Y73.59 E.00045
; LINE_WIDTH: 0.148738
G1 X78.563 Y73.649 E.0006
; LINE_WIDTH: 0.17583
G1 X78.485 Y73.709 E.00072
; LINE_WIDTH: 0.200949
G1 X78.407 Y73.769 E.00084
; LINE_WIDTH: 0.234563
G1 X78.255 Y73.892 E.00199
; LINE_WIDTH: 0.272798
G1 X78.106 Y74.017 E.00235
; LINE_WIDTH: 0.314637
G2 X77.817 Y74.273 I6.388 J7.479 E.00546
; LINE_WIDTH: 0.341137
G2 X77.144 Y74.96 I6.937 J7.475 E.01483
; LINE_WIDTH: 0.303272
G1 X77.017 Y75.106 E.00263
; LINE_WIDTH: 0.272803
G1 X76.892 Y75.255 E.00235
; LINE_WIDTH: 0.234571
G1 X76.769 Y75.407 E.00199
; LINE_WIDTH: 0.200982
G1 X76.709 Y75.485 E.00084
; LINE_WIDTH: 0.175912
G1 X76.649 Y75.563 E.00072
; LINE_WIDTH: 0.148815
G1 X76.59 Y75.643 E.0006
; LINE_WIDTH: 0.119679
G1 X76.531 Y75.723 E.00046
; LINE_WIDTH: 0.0890891
G1 X76.461 Y75.821 E.00037
; WIPE_START
G1 F21000
G1 X76.531 Y75.723 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.893 Y74.788 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.14326
G1 F5640
M204 S6000
G1 X79.716 Y74.906 E.00123
; LINE_WIDTH: 0.124999
G1 X79.625 Y74.97 E.00054
; LINE_WIDTH: 0.0903716
G1 X79.534 Y75.033 E.00035
; WIPE_START
G1 F21000
G1 X79.625 Y74.97 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.686 Y74.722 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.10127
G1 F5640
M204 S6000
G1 X80.454 Y74.643 E.0009
; WIPE_START
G1 F21000
G1 X80.686 Y74.722 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.694 Y74.766 Z7.2 F42000
G1 Z6.8
G1 E.8 F1800
; LINE_WIDTH: 0.0865794
G1 F5640
M204 S6000
G1 X81.533 Y74.68 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X81.694 Y74.766 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 57/73
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.2 I-1 J.693 P1  F42000
G1 X102.534 Y104.84 Z7.2
G1 Z6.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4346
M204 S5000
G1 X102.21 Y104.84 E.00625
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.594 Y104.84 E.00763
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14601
G1 X102.21 Y103.224 E-.61399
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.32 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 57 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer57 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z6.92
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4346
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.32 F42000
G1 X85.29 Y104.84 Z7.32
G1 Z6.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4346
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4346
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.44 Y87.439 Z7.32 F42000
G1 X80.625 Y82.108 Z7.32
G1 Z6.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4346
M204 S5000
G1 X80.354 Y82.077 E.00526
G3 X80.838 Y73.876 I.636 J-4.077 E.23461
G1 X80.98 Y73.874 E.00274
G3 X80.685 Y82.115 I.01 J4.126 E.25597
; WIPE_START
G1 F12000
M204 S6000
G1 X80.354 Y82.077 E-.1264
G1 X80.018 Y82.008 E-.13057
G1 X79.572 Y81.872 E-.17719
G1 X79.127 Y81.677 E-.18464
G1 X78.844 Y81.519 E-.12319
G1 X78.805 Y81.492 E-.01801
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.814 Y74.836 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4346
M204 S6000
G1 X75.631 Y74.782 E.00396
G3 X75.634 Y73.752 I15.737 J-.471 E.02137
G3 X76.841 Y72.631 I1.199 J.081 E.03765
G1 X77.782 Y72.631 E.01953
G1 X77.836 Y72.814 E.00396
G2 X75.846 Y74.785 I3.294 J5.316 E.0586
; WIPE_START
G1 F21000
G1 X75.631 Y74.782 E-.08165
G1 X75.634 Y73.752 E-.39144
G1 X75.672 Y73.52 E-.08939
G1 X75.755 Y73.3 E-.08925
G1 X75.88 Y73.1 E-.08985
G1 X75.913 Y73.064 E-.01842
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.434 Y74.362 Z7.32 F42000
G1 X86.186 Y74.836 Z7.32
G1 Z6.92
G1 E.8 F1800
G1 F4346
M204 S6000
G2 X84.164 Y72.814 I-5.316 J3.294 E.05985
G1 X84.218 Y72.631 E.00396
G3 X85.241 Y72.634 I.471 J15.589 E.02124
G3 X86.369 Y73.841 I-.074 J1.199 E.03778
G1 X86.369 Y74.782 E.01953
G1 X86.244 Y74.819 E.00271
; WIPE_START
G1 F21000
G1 X85.771 Y74.239 E-.2845
G1 X85.296 Y73.705 E-.27166
G1 X84.895 Y73.348 E-.20384
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.096 Y80.978 Z7.32 F42000
G1 X85.159 Y83.369 Z7.32
G1 Z6.92
G1 E.8 F1800
G1 F4346
M204 S6000
G1 X84.218 Y83.369 E.01953
G1 X84.164 Y83.186 E.00396
G2 X86.186 Y81.164 I-3.294 J-5.316 E.05985
G1 X86.369 Y81.218 E.00396
G3 X86.366 Y82.248 I-15.737 J.471 E.02137
G3 X85.219 Y83.368 I-1.199 J-.081 E.03641
; WIPE_START
G1 F21000
G1 X84.218 Y83.369 E-.38059
G1 X84.164 Y83.186 E-.07247
G1 X84.577 Y82.91 E-.18883
G1 X84.823 Y82.72 E-.11811
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.836 Y83.186 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
G1 F4346
M204 S6000
G1 X77.782 Y83.369 E.00396
G3 X76.752 Y83.366 I-.471 J-15.732 E.02137
G3 X75.631 Y82.159 I.081 J-1.199 E.03765
G1 X75.631 Y81.218 E.01953
G1 X75.814 Y81.164 E.00396
G1 X75.949 Y81.375 E.0052
G2 X77.785 Y83.154 I5.089 J-3.414 E.05343
; WIPE_START
G1 F21000
G1 X77.782 Y83.369 E-.08157
G1 X76.752 Y83.366 E-.39144
G1 X76.52 Y83.328 E-.08939
G1 X76.3 Y83.245 E-.08932
G1 X76.1 Y83.12 E-.08973
G1 X76.064 Y83.087 E-.01855
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.675 Y83.663 Z7.32 F42000
G1 X85.18 Y83.777 Z7.32
G1 Z6.92
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4346
M204 S5000
G1 X85.166 Y83.778 E.00027
G1 X76.834 Y83.778 E.1606
G3 X75.222 Y82.166 I.005 J-1.618 E.04878
G1 X75.222 Y73.834 E.1606
G3 X76.834 Y72.222 I1.618 J.005 E.04878
G1 X85.267 Y72.225 E.16255
G3 X86.778 Y73.834 I-.1 J1.608 E.04688
G1 X86.778 Y82.166 E.1606
G3 X85.483 Y83.746 I-1.618 J-.005 E.04263
G1 X85.239 Y83.771 E.00472
M204 S10000
G1 X84.955 Y83.156 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.589559
G1 F4346
M204 S6000
G1 X85.45 Y82.822 E.01646
G2 X85.821 Y82.452 I-.678 J-1.05 E.01455
; LINE_WIDTH: 0.554387
G1 X86.156 Y81.871 E.01733
M204 S10000
G1 X86.354 Y81 F42000
; LINE_WIDTH: 0.18206
G1 F4346
M204 S6000
G1 X86.496 Y80.274 E.00565
; LINE_WIDTH: 0.164527
G1 X86.514 Y80.174 E.00069
; LINE_WIDTH: 0.130953
G1 X86.533 Y80.074 E.00052
; LINE_WIDTH: 0.0973792
G1 X86.551 Y79.974 E.00036
M204 S10000
G1 X86.564 Y79.976 F42000
; LINE_WIDTH: 0.280319
G1 F4346
M204 S6000
G1 X86.34 Y80.996 E.01299
M204 S10000
G1 X86.33 Y80.993 F42000
; LINE_WIDTH: 0.392957
G1 F4346
M204 S6000
G2 X86.574 Y79.998 I-42.247 J-10.898 E.01838
M204 S10000
G1 X86.551 Y76.027 F42000
; LINE_WIDTH: 0.0975946
G1 F4346
M204 S6000
G1 X86.533 Y75.926 E.00036
; LINE_WIDTH: 0.131074
G1 X86.514 Y75.826 E.00052
; LINE_WIDTH: 0.179929
G2 X86.353 Y75 I-31.835 J5.788 E.00634
M204 S10000
G1 X86.34 Y75.004 F42000
; LINE_WIDTH: 0.280191
G1 F4346
M204 S6000
G1 X86.564 Y76.025 E.01299
M204 S10000
G1 X86.574 Y76.019 F42000
; LINE_WIDTH: 0.350466
G1 F4346
M204 S6000
G1 X86.333 Y75.006 E.01652
M204 S10000
G1 X86.157 Y74.112 F42000
; LINE_WIDTH: 0.567083
G1 F4346
M204 S6000
G1 X85.775 Y73.482 E.0195
; LINE_WIDTH: 0.589579
G2 X85.45 Y73.178 I-1.037 J.782 E.01232
G1 X84.954 Y72.844 E.01648
M204 S10000
G1 X83.999 Y72.648 F42000
; LINE_WIDTH: 0.182003
G1 F4346
M204 S6000
G1 X83.274 Y72.504 E.00565
; LINE_WIDTH: 0.16449
G1 X83.174 Y72.486 E.00069
; LINE_WIDTH: 0.130931
G1 X83.074 Y72.467 E.00052
; LINE_WIDTH: 0.0973718
G1 X82.974 Y72.449 E.00036
M204 S10000
G1 X82.976 Y72.435 F42000
; LINE_WIDTH: 0.283387
G1 F4346
M204 S6000
G1 X83.995 Y72.661 E.01315
M204 S10000
G1 X86.467 Y75.94 F42000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F4346
M204 S2000
G1 X83.06 Y72.533 E.09288
G1 X82.408 Y72.439
G1 X86.562 Y76.592 E.11323
G1 X86.562 Y77.15
G1 X81.85 Y72.439 E.12843
G1 X81.293 Y72.439
G1 X82.998 Y74.144 E.04648
G1 X82.094 Y73.797
M73 P83 R1
G1 X80.735 Y72.439 E.03704
G1 X80.178 Y72.439
G1 X81.416 Y73.677 E.03377
G1 X80.841 Y73.66
G1 X79.62 Y72.439 E.03328
G1 X79.1 Y72.476
G1 X80.332 Y73.708 E.03359
G1 X79.872 Y73.806
G1 X78.697 Y72.631 E.03203
G1 X78.318 Y72.81
G1 X79.451 Y73.943 E.03089
G1 X79.064 Y74.112
G1 X77.961 Y73.01 E.03005
G1 X77.625 Y73.232
G1 X78.706 Y74.312 E.02946
M73 P84 R1
G1 X78.376 Y74.54
G1 X77.309 Y73.472 E.02909
G1 X77.011 Y73.732
G1 X78.071 Y74.793 E.02892
G1 X77.793 Y75.072
G1 X76.732 Y74.011 E.02892
G1 X76.472 Y74.309
G1 X77.54 Y75.376 E.02909
G1 X77.312 Y75.706
G1 X76.231 Y74.625 E.02946
G1 X76.01 Y74.961
G1 X77.112 Y76.064 E.03005
G1 X76.943 Y76.452
G1 X75.81 Y75.319 E.0309
G1 X75.631 Y75.698
G1 X76.806 Y76.873 E.03203
G1 X76.708 Y77.332
G1 X75.476 Y76.1 E.03359
G1 X75.439 Y76.62
G1 X76.66 Y77.841 E.03328
G1 X76.677 Y78.416
G1 X75.439 Y77.178 E.03377
G1 X75.439 Y77.735
G1 X76.797 Y79.094 E.03704
G1 X77.144 Y79.998
G1 X75.439 Y78.293 E.04648
; WIPE_START
G1 F12000
M204 S6000
G1 X76.853 Y79.707 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.779 Y76.501 Z7.32 F42000
G1 X84.857 Y76.002 Z7.32
G1 Z6.92
G1 E.8 F1800
G1 F4346
M204 S2000
G1 X86.562 Y77.707 E.04648
G1 X86.562 Y78.265
G1 X85.203 Y76.906 E.03704
G1 X85.323 Y77.584
G1 X86.562 Y78.822 E.03377
G1 X86.562 Y79.38
G1 X85.341 Y78.159 E.03328
G1 X85.292 Y78.668
G1 X86.524 Y79.9 E.03359
G1 X86.369 Y80.303
G1 X85.194 Y79.128 E.03203
G1 X85.057 Y79.548
G1 X86.19 Y80.682 E.0309
G1 X85.99 Y81.039
G1 X84.888 Y79.936 E.03005
G1 X84.688 Y80.294
G1 X85.768 Y81.375 E.02946
G1 X85.528 Y81.691
G1 X84.46 Y80.624 E.02909
G1 X84.207 Y80.929
G1 X85.268 Y81.989 E.02892
G1 X84.989 Y82.268
G1 X83.929 Y81.207 E.02892
G1 X83.624 Y81.46
G1 X84.691 Y82.528 E.02909
G1 X84.375 Y82.769
G1 X83.294 Y81.688 E.02946
G1 X82.936 Y81.888
G1 X84.039 Y82.99 E.03005
G1 X83.682 Y83.191
G1 X82.549 Y82.058 E.03089
G1 X82.127 Y82.194
G1 X83.302 Y83.369 E.03203
G1 X82.9 Y83.524
G1 X81.668 Y82.292 E.03359
G1 X81.159 Y82.341
G1 X82.38 Y83.562 E.03328
G1 X81.822 Y83.562
G1 X80.584 Y82.323 E.03377
G1 X79.906 Y82.203
G1 X81.265 Y83.562 E.03704
G1 X80.707 Y83.562
G1 X79.002 Y81.856 E.04648
; WIPE_START
G1 F12000
M204 S6000
G1 X80.416 Y83.271 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.15 Y83.562 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
G1 F4346
M204 S2000
G1 X75.439 Y78.85 E.12843
G1 X75.439 Y79.408
G1 X79.592 Y83.562 E.11323
G1 X78.94 Y83.467
G1 X75.533 Y80.06 E.09287
M204 S10000
G1 X78.391 Y83.225 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0904206
G1 F4346
M204 S6000
G1 X78.284 Y83.148 E.00042
; LINE_WIDTH: 0.129373
G1 X78.166 Y83.06 E.00075
; LINE_WIDTH: 0.165566
G1 X78.075 Y82.99 E.00078
; LINE_WIDTH: 0.194743
G1 X77.985 Y82.92 E.00095
; LINE_WIDTH: 0.233771
G1 X77.808 Y82.778 E.00231
; LINE_WIDTH: 0.27821
G1 X77.634 Y82.633 E.0028
; LINE_WIDTH: 0.313648
G1 X77.465 Y82.485 E.00316
; LINE_WIDTH: 0.354514
G3 X76.515 Y81.535 I8.579 J-9.529 E.0216
; LINE_WIDTH: 0.31364
G1 X76.367 Y81.366 E.00317
; LINE_WIDTH: 0.278242
G1 X76.222 Y81.192 E.00279
; LINE_WIDTH: 0.233774
G1 X76.08 Y81.015 E.00231
; LINE_WIDTH: 0.194293
G1 X76.008 Y80.922 E.00097
; LINE_WIDTH: 0.164353
G1 X75.936 Y80.829 E.0008
; LINE_WIDTH: 0.130301
G1 X75.855 Y80.719 E.0007
; LINE_WIDTH: 0.0921389
G1 X75.774 Y80.608 E.00044
; WIPE_START
G1 F21000
G1 X75.855 Y80.719 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.837 Y82.272 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.120584
G1 F4346
M204 S6000
G1 X79.539 Y82.09 E.00162
M204 S10000
G1 X78.938 Y81.92 F42000
; LINE_WIDTH: 0.20775
G1 F4346
M204 S6000
G1 X78.842 Y81.849 E.00106
; LINE_WIDTH: 0.181513
G1 X78.705 Y81.743 E.00133
; LINE_WIDTH: 0.140864
G1 X78.57 Y81.635 E.00097
; LINE_WIDTH: 0.0952292
G1 X78.317 Y81.419 E.00113
; WIPE_START
G1 F21000
G1 X78.57 Y81.635 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.582 Y80.683 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.0953554
G1 F4346
M204 S6000
G1 X77.364 Y80.428 E.00114
; LINE_WIDTH: 0.141475
G1 X77.255 Y80.292 E.00099
; LINE_WIDTH: 0.173185
G1 X77.195 Y80.215 E.0007
; LINE_WIDTH: 0.190005
G1 X77.136 Y80.137 E.00078
G1 X77.157 Y79.985 E.00124
; WIPE_START
G1 F21000
G1 X77.136 Y80.137 E-.46511
G1 X77.195 Y80.215 E-.29489
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.928 Y76.62 Z7.32 F42000
G1 X86.226 Y75.392 Z7.32
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.0921724
G1 F4346
M204 S6000
G1 X86.145 Y75.282 E.00045
; LINE_WIDTH: 0.130402
G1 X86.064 Y75.171 E.0007
; LINE_WIDTH: 0.164467
G1 X85.992 Y75.078 E.0008
; LINE_WIDTH: 0.194408
G1 X85.92 Y74.985 E.00097
; LINE_WIDTH: 0.233875
G1 X85.778 Y74.808 E.00231
; LINE_WIDTH: 0.278351
G1 X85.633 Y74.634 E.00279
; LINE_WIDTH: 0.322493
G2 X85.389 Y74.359 I-7.134 J6.066 E.00534
; LINE_WIDTH: 0.356821
G2 X84.535 Y73.515 I-8.582 J7.83 E.01943
; LINE_WIDTH: 0.313767
G1 X84.366 Y73.368 E.00316
; LINE_WIDTH: 0.278337
G1 X84.192 Y73.222 E.0028
; LINE_WIDTH: 0.233893
G1 X84.015 Y73.08 E.00231
; LINE_WIDTH: 0.194868
G1 X83.925 Y73.01 E.00095
; LINE_WIDTH: 0.165686
G1 X83.834 Y72.94 E.00078
; LINE_WIDTH: 0.129483
G1 X83.716 Y72.852 E.00075
; LINE_WIDTH: 0.0904771
G1 X83.608 Y72.775 E.00042
; WIPE_START
G1 F21000
G1 X83.716 Y72.852 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.683 Y74.581 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.0953318
G1 F4346
M204 S6000
G1 X83.428 Y74.364 E.00114
; LINE_WIDTH: 0.141226
G1 X83.293 Y74.256 E.00098
; LINE_WIDTH: 0.182194
G1 X83.155 Y74.149 E.00134
; LINE_WIDTH: 0.207823
G1 X83.062 Y74.079 E.00103
; WIPE_START
G1 F21000
G1 X83.155 Y74.149 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.921 Y75.938 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.21075
G1 F4346
M204 S6000
G1 X84.862 Y75.859 E.0009
; LINE_WIDTH: 0.184878
G1 X84.745 Y75.708 E.00148
; LINE_WIDTH: 0.141154
G1 X84.635 Y75.57 E.00099
; LINE_WIDTH: 0.0951624
G1 X84.419 Y75.317 E.00113
; WIPE_START
G1 F21000
G1 X84.635 Y75.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.272 Y76.837 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.130518
G1 F4346
M204 S6000
G1 X85.09 Y76.538 E.00179
; WIPE_START
G1 F21000
G1 X85.272 Y76.837 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.993 Y83.33 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.393033
G1 F4346
M204 S6000
G3 X82.999 Y83.574 I-11.115 J-43.087 E.01837
M204 S10000
G1 X82.976 Y83.563 F42000
; LINE_WIDTH: 0.280273
G1 F4346
M204 S6000
G1 X83.996 Y83.34 E.01299
M204 S10000
G1 X83.999 Y83.352 F42000
; LINE_WIDTH: 0.182073
G1 F4346
M204 S6000
G1 X83.274 Y83.496 E.00565
; LINE_WIDTH: 0.164544
G1 X83.174 Y83.514 E.00069
; LINE_WIDTH: 0.130966
G1 X83.074 Y83.533 E.00052
; LINE_WIDTH: 0.0973891
G1 X82.974 Y83.551 E.00036
M204 S10000
G1 X79.026 Y83.551 F42000
; LINE_WIDTH: 0.0973718
G1 F4346
M204 S6000
G1 X78.926 Y83.533 E.00036
; LINE_WIDTH: 0.130931
G1 X78.826 Y83.514 E.00052
; LINE_WIDTH: 0.179872
G3 X78.001 Y83.352 I5.519 J-30.239 E.00634
M204 S10000
G1 X78.005 Y83.339 F42000
; LINE_WIDTH: 0.283382
G1 F4346
M204 S6000
G1 X79.024 Y83.565 E.01315
; WIPE_START
G1 F21000
G1 X78.005 Y83.339 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.046 Y83.156 Z7.32 F42000
G1 Z6.92
G1 E.8 F1800
; LINE_WIDTH: 0.589677
G1 F4346
M204 S6000
G1 X76.541 Y82.816 E.01677
G3 X76.179 Y82.452 I.676 J-1.033 E.01426
; LINE_WIDTH: 0.564544
G3 X75.843 Y81.91 I19.952 J-12.738 E.0168
M204 S10000
G1 X75.648 Y80.999 F42000
; LINE_WIDTH: 0.182202
G1 F4346
M204 S6000
G1 X75.504 Y80.275 E.00565
; LINE_WIDTH: 0.159218
G1 X75.482 Y80.156 E.00079
; LINE_WIDTH: 0.114155
G1 X75.459 Y80.036 E.00053
; LINE_WIDTH: 0.08563
G1 X75.449 Y79.973 E.00019
M204 S10000
G1 X75.436 Y79.975 F42000
; LINE_WIDTH: 0.280253
G1 F4346
M204 S6000
G1 X75.66 Y80.996 E.013
M204 S10000
G1 X75.667 Y80.994 F42000
; LINE_WIDTH: 0.35023
G1 F4346
M204 S6000
G1 X75.426 Y79.978 E.01656
M204 S10000
G1 X75.449 Y76.026 F42000
; LINE_WIDTH: 0.0973823
G1 F4346
M204 S6000
G1 X75.467 Y75.926 E.00036
; LINE_WIDTH: 0.130963
G1 X75.486 Y75.826 E.00052
; LINE_WIDTH: 0.164543
G1 X75.504 Y75.726 E.00069
; LINE_WIDTH: 0.182064
G1 X75.648 Y75.001 E.00565
M204 S10000
G1 X75.66 Y75.004 F42000
; LINE_WIDTH: 0.280348
G1 F4346
M204 S6000
G1 X75.437 Y76.024 E.013
M204 S10000
G1 X75.426 Y76.005 F42000
; LINE_WIDTH: 0.392945
G1 F4346
M204 S6000
G3 X75.67 Y75.007 I38.712 J8.942 E.01844
M204 S10000
G1 X75.844 Y74.129 F42000
; LINE_WIDTH: 0.553946
G1 F4346
M204 S6000
G1 X76.171 Y73.56 E.01695
; LINE_WIDTH: 0.607411
G3 X76.519 Y73.198 I1.096 J.706 E.01435
; LINE_WIDTH: 0.567287
G1 X77.084 Y72.843 E.01767
M204 S10000
G1 X78.001 Y72.647 F42000
; LINE_WIDTH: 0.179948
G1 F4346
M204 S6000
G3 X78.826 Y72.486 I6.777 J32.43 E.00634
; LINE_WIDTH: 0.130966
G1 X78.926 Y72.467 E.00052
; LINE_WIDTH: 0.0973887
G1 X79.026 Y72.449 E.00036
M204 S10000
G1 X79.024 Y72.435 F42000
; LINE_WIDTH: 0.280296
G1 F4346
M204 S6000
G1 X78.004 Y72.661 E.01299
M204 S10000
G1 X78.007 Y72.67 F42000
; LINE_WIDTH: 0.393046
G1 F4346
M204 S6000
G3 X79.001 Y72.426 I10.982 J42.539 E.01837
; CHANGE_LAYER
; Z_HEIGHT: 7.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X78.007 Y72.67 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 58/73
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.32 I-.968 J.738 P1  F42000
G1 X102.534 Y104.84 Z7.32
G1 Z7.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4141
M204 S5000
G1 X102.21 Y104.84 E.00624
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.594 Y104.84 E.00764
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14585
G1 X102.21 Y103.224 E-.61415
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.44 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 58 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer58 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.04
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4141
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.44 F42000
G1 X85.29 Y104.84 Z7.44
G1 Z7.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4141
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F4141
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.392 Y87.456 Z7.44 F42000
G1 X80.815 Y82.922 Z7.44
G1 Z7.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4141
M204 S5000
G1 X80.421 Y82.895 E.00761
G3 X80.809 Y73.07 I.579 J-4.897 E.28374
G1 X81.192 Y73.07 E.00739
G3 X81 Y82.93 I-.192 J4.928 E.29494
G1 X80.875 Y82.925 E.00242
; WIPE_START
G1 F12000
M204 S6000
M73 P85 R1
G1 X80.421 Y82.895 E-.1728
G1 X80.037 Y82.839 E-.14725
G1 X79.475 Y82.692 E-.22068
G1 X79.112 Y82.558 E-.14721
G1 X78.941 Y82.477 E-.07206
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.516 Y75.24 Z7.44 F42000
G1 X75.929 Y73.488 Z7.44
G1 Z7.04
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4141
M204 S6000
G1 X75.742 Y73.359 E.00471
G3 X76.359 Y72.742 I1.159 J.542 E.01847
G1 X76.488 Y72.927 E.00469
G2 X75.969 Y73.444 I6.648 J7.195 E.01519
; WIPE_START
G1 F21000
G1 X75.742 Y73.359 E-.09236
G1 X75.846 Y73.175 E-.08026
G1 X75.997 Y72.992 E-.09029
G1 X76.175 Y72.846 E-.08742
G1 X76.359 Y72.742 E-.08033
G1 X76.488 Y72.927 E-.08595
G1 X76.199 Y73.199 E-.15082
G1 X76.032 Y73.377 E-.09257
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.664 Y73.461 Z7.44 F42000
G1 X86.073 Y73.488 Z7.44
G1 Z7.04
G1 E.8 F1800
G1 F4141
M204 S6000
G2 X85.512 Y72.929 I-7.188 J6.641 E.01643
G1 X85.641 Y72.742 E.00471
G1 X85.759 Y72.805 E.00277
G3 X86.258 Y73.359 I-.625 J1.065 E.01572
G1 X86.122 Y73.454 E.00345
; WIPE_START
G1 F21000
G1 X85.801 Y73.199 E-.15571
G1 X85.512 Y72.929 E-.15033
G1 X85.641 Y72.742 E-.08632
G1 X85.759 Y72.805 E-.0507
G1 X85.888 Y72.891 E-.05919
G1 X86.059 Y73.051 E-.08893
G1 X86.154 Y73.175 E-.05926
G1 X86.258 Y73.359 E-.08033
G1 X86.195 Y73.403 E-.02923
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.767 Y81.023 Z7.44 F42000
G1 X85.641 Y83.258 Z7.44
G1 Z7.04
G1 E.8 F1800
G1 F4141
M204 S6000
G1 X85.512 Y83.073 E.00469
G2 X86.071 Y82.512 I-6.637 J-7.184 E.01643
G1 X86.258 Y82.641 E.00471
G3 X85.695 Y83.232 I-1.158 J-.542 E.01723
; WIPE_START
G1 F21000
G1 X85.512 Y83.073 E-.0921
G1 X85.801 Y82.802 E-.15071
G1 X86.071 Y82.512 E-.1504
G1 X86.258 Y82.641 E-.08632
G1 X86.154 Y82.825 E-.08026
G1 X86.003 Y83.008 E-.09029
G1 X85.825 Y83.154 E-.08739
G1 X85.774 Y83.184 E-.02253
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.142 Y83.091 Z7.44 F42000
G1 X76.488 Y83.071 Z7.44
G1 Z7.04
G1 E.8 F1800
G1 F4141
M204 S6000
G1 X76.359 Y83.258 E.00471
G3 X75.742 Y82.641 I.542 J-1.159 E.01847
G1 X75.927 Y82.512 E.00469
G1 X76.014 Y82.609 E.00271
G2 X76.443 Y83.031 I4.972 J-4.627 E.01249
; WIPE_START
G1 F21000
G1 X76.359 Y83.258 E-.09196
G1 X76.175 Y83.154 E-.08026
G1 X75.992 Y83.003 E-.09029
G1 X75.846 Y82.825 E-.08741
G1 X75.742 Y82.641 E-.08033
G1 X75.927 Y82.512 E-.08594
G1 X76.014 Y82.609 E-.0496
G1 X76.378 Y82.968 E-.19421
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X83.98 Y83.655 Z7.44 F42000
G1 X85.175 Y83.763 Z7.44
G1 Z7.04
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4141
M204 S5000
G1 X85.159 Y83.765 E.00031
G1 X76.841 Y83.765 E.16034
G3 X75.235 Y82.159 I.005 J-1.611 E.04858
G1 X75.235 Y73.841 E.16034
G3 X76.841 Y72.235 I1.611 J.005 E.04858
G1 X85.263 Y72.239 E.16234
G3 X86.765 Y73.841 I-.103 J1.601 E.04662
G1 X86.765 Y82.159 E.16034
G3 X85.479 Y83.732 I-1.611 J-.005 E.04237
G1 X85.234 Y83.757 E.00474
M204 S10000
G1 X85.415 Y83.292 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.11803
G1 F4141
M204 S6000
G1 X84.593 Y83.542 E.00387
M204 S10000
G1 X84.595 Y83.546 F42000
; LINE_WIDTH: 0.282622
G1 F4141
M204 S6000
G1 X85.408 Y83.282 E.01074
M204 S10000
G1 X85.403 Y83.274 F42000
; LINE_WIDTH: 0.434951
G1 F4141
M204 S6000
G1 X84.598 Y83.559 E.01707
M204 S10000
G1 X84.094 Y83.548 F42000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F4141
M204 S2000
G1 X86.548 Y81.094 E.0669
G1 X86.548 Y80.536
G1 X83.536 Y83.548 E.0821
G1 X82.979 Y83.548
G1 X86.548 Y79.979 E.0973
G1 X85.541 Y80.429
G1 X86.548 Y79.421 E.02746
G1 X86.548 Y78.864
G1 X85.932 Y79.48 E.01679
G1 X86.092 Y78.762
G1 X86.548 Y78.306 E.01242
G1 X86.548 Y77.749
G1 X86.147 Y78.149 E.01092
G1 X86.135 Y77.604
G1 X86.548 Y77.191 E.01126
G1 X86.548 Y76.634
G1 X86.072 Y77.11 E.01298
G1 X85.97 Y76.654
G1 X86.548 Y76.076 E.01575
G1 X86.548 Y75.518
G1 X85.836 Y76.23 E.0194
G1 X85.673 Y75.836
G1 X86.548 Y74.961 E.02384
G1 X86.508 Y74.443
G1 X85.484 Y75.467 E.02792
G1 X85.271 Y75.123
G1 X86.281 Y74.113 E.02753
G1 X86.036 Y73.8
G1 X85.036 Y74.801 E.02727
G1 X84.778 Y74.5
G1 X85.774 Y73.505 E.02714
G1 X85.495 Y73.226
G1 X84.5 Y74.222 E.02714
G1 X84.199 Y73.964
G1 X85.2 Y72.964 E.02727
G1 X84.887 Y72.719
G1 X83.877 Y73.729 E.02753
G1 X83.533 Y73.516
G1 X84.557 Y72.492 E.02792
G1 X84.039 Y72.452
G1 X83.164 Y73.327 E.02384
G1 X82.77 Y73.164
G1 X83.481 Y72.452 E.0194
G1 X82.924 Y72.452
G1 X82.346 Y73.03 E.01575
G1 X81.89 Y72.928
G1 X82.366 Y72.452 E.01298
G1 X81.809 Y72.452
G1 X81.396 Y72.865 E.01126
G1 X80.85 Y72.854
G1 X81.251 Y72.452 E.01094
G1 X80.694 Y72.452
G1 X80.239 Y72.907 E.0124
G1 X79.52 Y73.068
G1 X80.136 Y72.452 E.01679
G1 X79.579 Y72.452
G1 X78.571 Y73.46 E.02747
; WIPE_START
G1 F12000
M204 S6000
G1 X79.579 Y72.452 E-.54151
G1 X80.136 Y72.452 E-.21187
G1 X80.124 Y72.464 E-.00663
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.503 Y79.717 Z7.44 F42000
G1 X83.429 Y82.541 Z7.44
G1 Z7.04
G1 E.8 F1800
G1 F4141
M204 S2000
G1 X82.421 Y83.548 E.02746
G1 X81.864 Y83.548
G1 X82.48 Y82.932 E.01679
G1 X81.761 Y83.093
G1 X81.306 Y83.548 E.0124
G1 X80.749 Y83.548
G1 X81.149 Y83.147 E.01092
G1 X80.604 Y83.135
G1 X80.191 Y83.548 E.01126
G1 X79.634 Y83.548
G1 X80.11 Y83.072 E.01298
G1 X79.654 Y82.97
G1 X79.076 Y83.548 E.01575
G1 X78.518 Y83.548
G1 X79.23 Y82.836 E.0194
G1 X78.836 Y82.673
G1 X77.961 Y83.548 E.02385
G1 X77.443 Y83.508
G1 X78.467 Y82.484 E.02792
G1 X78.123 Y82.271
G1 X77.113 Y83.281 E.02753
G1 X76.8 Y83.036
G1 X77.801 Y82.036 E.02727
G1 X77.5 Y81.778
G1 X76.505 Y82.774 E.02714
G1 X76.226 Y82.495
G1 X77.222 Y81.5 E.02714
G1 X76.964 Y81.199
G1 X75.964 Y82.2 E.02727
G1 X75.719 Y81.887
G1 X76.729 Y80.877 E.02753
G1 X76.516 Y80.533
G1 X75.492 Y81.557 E.02792
G1 X75.452 Y81.039
G1 X76.327 Y80.164 E.02384
G1 X76.164 Y79.77
G1 X75.452 Y80.481 E.0194
G1 X75.452 Y79.924
G1 X76.03 Y79.346 E.01575
G1 X75.928 Y78.89
G1 X75.452 Y79.366 E.01298
G1 X75.452 Y78.809
G1 X75.865 Y78.396 E.01126
G1 X75.853 Y77.851
G1 X75.452 Y78.251 E.01092
G1 X75.452 Y77.694
G1 X75.908 Y77.238 E.01242
G1 X76.068 Y76.52
G1 X75.452 Y77.136 E.01679
G1 X75.452 Y76.579
G1 X76.46 Y75.571 E.02747
G1 X75.452 Y76.021
G1 X79.021 Y72.452 E.09729
G1 X78.464 Y72.452
G1 X75.452 Y75.464 E.08209
G1 X75.452 Y74.906
G1 X77.906 Y72.452 E.0669
; WIPE_START
G1 F12000
M204 S6000
G1 X76.492 Y73.866 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.893 Y74.89 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0941024
G1 F4141
M204 S6000
G1 X76.694 Y75.124 E.00103
; LINE_WIDTH: 0.142138
G1 X76.566 Y75.284 E.00117
; LINE_WIDTH: 0.182556
G1 X76.417 Y75.476 E.00186
; WIPE_START
G1 F21000
G1 X76.566 Y75.284 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.583 Y72.432 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.152806
G1 F4141
M204 S6000
G1 X77.386 Y72.591 E.00157
; LINE_WIDTH: 0.19328
G1 X77.189 Y72.755 E.0021
; LINE_WIDTH: 0.233396
G1 X76.997 Y72.923 E.00259
; LINE_WIDTH: 0.279743
G2 X75.923 Y73.997 I9.714 J10.788 E.01888
; LINE_WIDTH: 0.233387
G1 X75.755 Y74.189 E.00259
; LINE_WIDTH: 0.193273
G1 X75.591 Y74.386 E.0021
; LINE_WIDTH: 0.152802
G1 X75.432 Y74.583 E.00157
; WIPE_START
G1 F21000
G1 X75.591 Y74.386 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.201 Y76.134 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.100797
G1 F4141
M204 S6000
G1 X75.998 Y76.45 E.00138
; WIPE_START
G1 F21000
G1 X76.201 Y76.134 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.783 Y77.642 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.0869187
G1 F4141
M204 S6000
G1 X75.87 Y77.868 E.00073
M204 S10000
G1 X75.927 Y78.865 F42000
; LINE_WIDTH: 0.0934698
G1 F4141
M204 S6000
G3 X75.842 Y78.698 I5.679 J-3.001 E.00062
; WIPE_START
G1 F21000
G1 X75.927 Y78.865 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X80.302 Y83.159 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.0935272
G1 F4141
M204 S6000
G1 X80.134 Y83.073 E.00062
; WIPE_START
G1 F21000
G1 X80.302 Y83.159 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.357 Y83.218 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.0870653
G1 F4141
M204 S6000
G1 X81.131 Y83.129 E.00073
; WIPE_START
G1 F21000
G1 X81.357 Y83.218 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X82.866 Y82.8 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.100635
G1 F4141
M204 S6000
G1 X82.549 Y83.002 E.00138
; WIPE_START
G1 F21000
G1 X82.866 Y82.8 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.113 Y82.103 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.0937058
G1 F4141
M204 S6000
G1 X83.876 Y82.306 E.00104
; LINE_WIDTH: 0.142023
G1 X83.716 Y82.434 E.00117
; LINE_WIDTH: 0.187011
G1 X83.568 Y82.548 E.00147
G1 X83.415 Y82.527 E.00121
; WIPE_START
G1 F21000
G1 X83.568 Y82.548 E-.34368
G1 X83.716 Y82.434 E-.41632
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.568 Y81.417 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.152892
G1 F4141
M204 S6000
G1 X86.409 Y81.614 E.00157
; LINE_WIDTH: 0.193367
G1 X86.245 Y81.811 E.0021
; LINE_WIDTH: 0.233482
G1 X86.077 Y82.003 E.00258
; LINE_WIDTH: 0.279837
G3 X85.003 Y83.077 I-10.793 J-9.718 E.01889
; LINE_WIDTH: 0.233508
G1 X84.811 Y83.245 E.00259
; LINE_WIDTH: 0.193386
G1 X84.614 Y83.409 E.0021
; LINE_WIDTH: 0.152912
G1 X84.417 Y83.568 E.00157
; WIPE_START
G1 F21000
G1 X84.614 Y83.409 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.583 Y80.523 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.182298
M73 P86 R1
G1 F4141
M204 S6000
G1 X85.433 Y80.718 E.00188
; LINE_WIDTH: 0.141535
G1 X85.304 Y80.877 E.00116
; LINE_WIDTH: 0.0938978
G1 X85.108 Y81.109 E.00101
; WIPE_START
G1 F21000
G1 X85.304 Y80.877 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.001 Y79.549 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.100699
G1 F4141
M204 S6000
G1 X85.8 Y79.866 E.00138
; WIPE_START
G1 F21000
G1 X86.001 Y79.549 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.218 Y78.357 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.0870698
G1 F4141
M204 S6000
G1 X86.129 Y78.131 E.00073
M204 S10000
G1 X86.159 Y77.302 F42000
; LINE_WIDTH: 0.0935235
G1 F4141
M204 S6000
G1 X86.073 Y77.134 E.00062
; WIPE_START
G1 F21000
G1 X86.159 Y77.302 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X81.865 Y72.927 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.0934755
G1 F4141
M204 S6000
G2 X81.698 Y72.842 I-3.016 J5.707 E.00062
M204 S10000
G1 X80.867 Y72.871 F42000
; LINE_WIDTH: 0.0817692
G1 F4141
M204 S6000
G1 X80.642 Y72.782 E.00066
; WIPE_START
G1 F21000
G1 X80.867 Y72.871 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X79.45 Y72.998 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.100745
G1 F4141
M204 S6000
G1 X79.134 Y73.201 E.00138
M204 S10000
G1 X78.584 Y73.473 F42000
; LINE_WIDTH: 0.186669
G1 F4141
M204 S6000
G1 X78.432 Y73.452 E.00121
G1 X78.282 Y73.567 E.00149
; LINE_WIDTH: 0.141627
G1 X78.123 Y73.696 E.00116
; LINE_WIDTH: 0.0935941
G1 X77.886 Y73.897 E.00103
; WIPE_START
G1 F21000
G1 X78.123 Y73.696 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.402 Y72.441 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.430199
G1 F4141
M204 S6000
G1 X76.804 Y72.653 E.01253
G1 X76.759 Y72.958 E.00609
M204 S10000
G1 X76.592 Y72.718 F42000
; LINE_WIDTH: 0.282616
G1 F4141
M204 S6000
G1 X77.405 Y72.454 E.01074
M204 S10000
G1 X77.407 Y72.458 F42000
; LINE_WIDTH: 0.118022
G1 F4141
M204 S6000
G1 X76.586 Y72.709 E.00387
; WIPE_START
G1 F21000
G1 X77.407 Y72.458 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.708 Y73.584 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.118072
G1 F4141
M204 S6000
G1 X75.458 Y74.407 E.00388
M204 S10000
G1 X75.454 Y74.405 F42000
; LINE_WIDTH: 0.282586
G1 F4141
M204 S6000
G1 X75.719 Y73.592 E.01075
M204 S10000
G1 X75.959 Y73.758 F42000
; LINE_WIDTH: 0.43086
G1 F4141
M204 S6000
G1 X75.653 Y73.804 E.00613
G1 X75.441 Y74.402 E.01257
M204 S10000
G1 X75.441 Y81.598 F42000
; LINE_WIDTH: 0.430257
G1 F4141
M204 S6000
G1 X75.653 Y82.196 E.01253
G1 X75.958 Y82.241 E.0061
M204 S10000
G1 X75.718 Y82.408 F42000
; LINE_WIDTH: 0.282608
G1 F4141
M204 S6000
G1 X75.454 Y81.595 E.01074
M204 S10000
G1 X75.458 Y81.593 F42000
; LINE_WIDTH: 0.118022
G1 F4141
M204 S6000
G1 X75.709 Y82.414 E.00387
; WIPE_START
G1 F21000
G1 X75.458 Y81.593 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.585 Y83.291 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.11808
G1 F4141
M204 S6000
G1 X77.407 Y83.542 E.00388
M204 S10000
G1 X77.406 Y83.546 F42000
; LINE_WIDTH: 0.282669
G1 F4141
M204 S6000
G1 X76.591 Y83.282 E.01075
M204 S10000
G1 X76.757 Y83.042 F42000
; LINE_WIDTH: 0.430945
G1 F4141
M204 S6000
G1 X76.804 Y83.347 E.00612
G1 X77.402 Y83.559 E.01257
; WIPE_START
G1 F21000
G1 X76.804 Y83.347 E-.51108
G1 X76.757 Y83.042 E-.24892
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.373 Y82.535 Z7.44 F42000
G1 X86.281 Y82.408 Z7.44
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.282645
G1 F4141
M204 S6000
G1 X86.546 Y81.595 E.01075
M204 S10000
G1 X86.542 Y81.593 F42000
; LINE_WIDTH: 0.118096
G1 F4141
M204 S6000
G1 X86.292 Y82.416 E.00388
M204 S10000
G1 X86.511 Y82.522 F42000
; LINE_WIDTH: 0.431474
G1 F4141
M204 S6000
G1 X86.347 Y82.196 E.00723
G1 X86.559 Y81.598 E.01259
M204 S10000
G1 X86.559 Y74.402 F42000
; LINE_WIDTH: 0.431102
G1 F4141
M204 S6000
G1 X86.347 Y73.804 E.01256
G1 X86.512 Y73.475 E.00729
M204 S10000
G1 X86.291 Y73.586 F42000
; LINE_WIDTH: 0.118022
G1 F4141
M204 S6000
G1 X86.542 Y74.407 E.00387
M204 S10000
G1 X86.546 Y74.405 F42000
; LINE_WIDTH: 0.282616
G1 F4141
M204 S6000
G1 X86.282 Y73.592 E.01074
; WIPE_START
G1 F21000
G1 X86.546 Y74.405 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.414 Y72.71 Z7.44 F42000
G1 Z7.04
G1 E.8 F1800
; LINE_WIDTH: 0.117962
G1 F4141
M204 S6000
G1 X84.593 Y72.458 E.00387
M204 S10000
G1 X84.595 Y72.454 F42000
; LINE_WIDTH: 0.282586
G1 F4141
M204 S6000
G1 X85.408 Y72.719 E.01074
M204 S10000
G1 X85.403 Y72.726 F42000
; LINE_WIDTH: 0.435178
G1 F4141
M204 S6000
G1 X84.598 Y72.441 E.01709
; CHANGE_LAYER
; Z_HEIGHT: 7.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X85.403 Y72.726 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 59/73
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.44 I-1.074 J.573 P1  F42000
G1 X102.533 Y104.84 Z7.44
G1 Z7.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2947
M204 S5000
G1 X102.21 Y104.84 E.00623
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.593 Y104.84 E.00764
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.1457
G1 X102.21 Y103.223 E-.6143
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.56 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 59 start: 77,88
M624 BgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer59 end: 77,88
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F2947
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.56 F42000
G1 X85.29 Y104.84 Z7.56
G1 Z7.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2947
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F2947
M204 S6000
G1 X84.9 Y92.665 E.217
; OBJECT_ID: 88
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; start printing object, unique label id: 88
M624 BAAAAAAAAAA=
M204 S10000
G1 X82.406 Y87.451 Z7.56 F42000
G1 X81.09 Y83.644 Z7.56
G1 Z7.16
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2947
M204 S5000
G1 X81 Y83.644 E.00173
G3 X80.778 Y72.356 I0 J-5.647 E.33765
G3 X81.221 Y72.356 I.222 J7.144 E.00853
G3 X81.663 Y83.605 I-.22 J5.642 E.32488
G1 X81.149 Y83.64 E.00993
; WIPE_START
G1 F12000
M204 S6000
G1 X81 Y83.644 E-.05682
G1 X80.336 Y83.61 E-.25259
G1 X79.898 Y83.54 E-.16866
G1 X79.254 Y83.372 E-.2527
G1 X79.182 Y83.346 E-.02923
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X85.17 Y83.75 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
G1 F2947
M204 S5000
G1 X85.152 Y83.751 E.00034
G1 X76.848 Y83.751 E.16007
G3 X75.249 Y82.152 I.005 J-1.604 E.04837
G1 X75.249 Y73.848 E.16007
G3 X76.848 Y72.249 I1.604 J.005 E.04837
G1 X85.258 Y72.252 E.16211
G3 X86.751 Y73.848 I-.105 J1.594 E.04639
G1 X86.751 Y82.152 E.16007
G3 X85.467 Y83.719 I-1.604 J-.005 E.04227
G1 X85.229 Y83.743 E.0046
; WIPE_START
G1 F12000
M204 S6000
G1 X85.152 Y83.751 E-.02948
G1 X83.23 Y83.751 E-.73053
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.011 Y83.326 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.169929
G1 F2947
M204 S6000
G1 X83.266 Y83.475 E.00536
; LINE_WIDTH: 0.147144
G1 X83.133 Y83.5 E.0008
; LINE_WIDTH: 0.102847
G1 X83.001 Y83.524 E.00051
M204 S10000
G1 X83.003 Y83.536 F42000
; LINE_WIDTH: 0.268731
G1 F2947
M204 S6000
G1 X84.007 Y83.314 E.01222
M204 S10000
G1 X84.004 Y83.303 F42000
; LINE_WIDTH: 0.407711
G1 F2947
M204 S6000
G3 X83.022 Y83.547 I-10.946 J-42.026 E.01889
; WIPE_START
G1 F21000
G1 X84.004 Y83.303 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.531 Y82.137 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2947
M204 S2000
G1 X85.784 Y81.39 E.02036
G1 X85.538 Y81.701
G1 X86.452 Y82.616 E.02492
G1 X86.255 Y82.976
G1 X85.284 Y82.005 E.02646
G1 X85.005 Y82.284
G1 X85.98 Y83.259 E.02657
G1 X85.613 Y83.45
G1 X84.701 Y82.538 E.02486
G1 X84.39 Y82.784
G1 X85.141 Y83.534 E.02046
; WIPE_START
G1 F12000
M204 S6000
G1 X84.39 Y82.784 E-.40325
G1 X84.701 Y82.538 E-.15082
G1 X85.085 Y82.921 E-.20593
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.293 Y82.851 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0787726
G1 F2947
M204 S6000
G1 X84.23 Y82.903 E.00021
; LINE_WIDTH: 0.105948
G1 X84.215 Y82.939 E.00015
; LINE_WIDTH: 0.16807
G1 X84.178 Y83.189 E.00176
; WIPE_START
G1 F21000
G1 X84.215 Y82.939 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.551 Y81.521 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.166451
G1 F2947
M204 S6000
G1 X85.972 Y81.2 E.00456
; LINE_WIDTH: 0.145596
G1 X85.937 Y81.215 E.00022
; LINE_WIDTH: 0.104866
G1 X85.903 Y81.23 E.00015
; LINE_WIDTH: 0.0787974
G1 X85.851 Y81.293 E.00021
M204 S10000
G1 X86.307 Y81.005 F42000
; LINE_WIDTH: 0.376068
G1 F2947
M204 S6000
G1 X86.547 Y80.005 E.01762
M204 S10000
G1 X86.535 Y80.003 F42000
; LINE_WIDTH: 0.267838
G1 F2947
M204 S6000
G1 X86.315 Y81.008 E.01217
M204 S10000
G1 X86.327 Y81.011 F42000
; LINE_WIDTH: 0.169923
G1 F2947
M204 S6000
G1 X86.475 Y80.266 E.00536
; LINE_WIDTH: 0.147157
G1 X86.5 Y80.133 E.0008
; LINE_WIDTH: 0.10286
G1 X86.524 Y80.001 E.00051
; WIPE_START
G1 F21000
G1 X86.5 Y80.133 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.524 Y75.999 Z7.56 F42000
G1 Z7.16
M73 P87 R1
G1 E.8 F1800
; LINE_WIDTH: 0.102847
G1 F2947
M204 S6000
G1 X86.5 Y75.867 E.00051
; LINE_WIDTH: 0.166499
G2 X86.326 Y74.989 I-34.861 J6.426 E.00616
M204 S10000
G1 X86.314 Y74.993 F42000
; LINE_WIDTH: 0.268731
G1 F2947
M204 S6000
G1 X86.536 Y75.997 E.01222
M204 S10000
G1 X86.547 Y75.978 F42000
; LINE_WIDTH: 0.407711
G1 F2947
M204 S6000
G2 X86.303 Y74.996 I-42.269 J9.964 E.01889
; WIPE_START
G1 F21000
G1 X86.547 Y75.978 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.529 Y73.772 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2947
M204 S2000
G1 X85.226 Y72.469 E.03552
G1 X84.668 Y72.469
G1 X86.534 Y74.335 E.05086
G1 X86.391 Y74.749
G1 X84.249 Y72.607 E.05839
; WIPE_START
G1 F12000
M204 S6000
G1 X85.663 Y74.021 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.059 Y74.855 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.212763
G1 F2947
M204 S6000
G1 X85.923 Y74.689 E.00196
; LINE_WIDTH: 0.181119
G1 X85.782 Y74.518 E.00168
; LINE_WIDTH: 0.148233
G1 X85.552 Y74.264 E.00205
; LINE_WIDTH: 0.104782
G1 X84.989 Y73.677 E.00314
; LINE_WIDTH: 0.114616
G1 X84.736 Y73.447 E.00149
; LINE_WIDTH: 0.148589
G1 X84.477 Y73.213 E.0021
; LINE_WIDTH: 0.181418
G1 X84.312 Y73.078 E.00162
; LINE_WIDTH: 0.212094
G1 X84.148 Y72.943 E.00194
; WIPE_START
G1 F21000
G1 X84.312 Y73.078 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X86.457 Y73.394 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.0947119
G1 F2947
M204 S6000
G1 X86.381 Y73.284 E.00045
; LINE_WIDTH: 0.13802
G1 X86.306 Y73.175 E.00073
; LINE_WIDTH: 0.184758
G2 X85.818 Y72.689 I-2.422 J1.942 E.00537
; LINE_WIDTH: 0.14345
G1 X85.715 Y72.615 E.00073
; LINE_WIDTH: 0.115687
G1 X85.612 Y72.541 E.00056
; WIPE_START
G1 F21000
G1 X85.715 Y72.615 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X84.011 Y72.673 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.169923
G1 F2947
M204 S6000
G1 X83.266 Y72.525 E.00536
; LINE_WIDTH: 0.147157
G1 X83.133 Y72.5 E.0008
; LINE_WIDTH: 0.10286
G1 X83.001 Y72.476 E.00051
M204 S10000
G1 X83.003 Y72.465 F42000
; LINE_WIDTH: 0.267838
G1 F2947
M204 S6000
G1 X84.008 Y72.685 E.01217
M204 S10000
G1 X84.005 Y72.693 F42000
; LINE_WIDTH: 0.376068
G1 F2947
M204 S6000
G1 X83.005 Y72.453 E.01762
; WIPE_START
G1 F21000
G1 X84.005 Y72.693 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X78.999 Y72.476 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.102847
G1 F2947
M204 S6000
G1 X78.867 Y72.5 E.00051
; LINE_WIDTH: 0.166499
G2 X77.989 Y72.674 I6.426 J34.861 E.00616
M204 S10000
G1 X77.993 Y72.686 F42000
; LINE_WIDTH: 0.268731
G1 F2947
M204 S6000
G1 X78.997 Y72.464 E.01222
M204 S10000
G1 X78.978 Y72.453 F42000
; LINE_WIDTH: 0.407711
G1 F2947
M204 S6000
G2 X77.996 Y72.697 I9.964 J42.269 E.01889
; WIPE_START
G1 F21000
G1 X78.978 Y72.453 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.863 Y72.469 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2947
M204 S2000
G1 X77.61 Y73.216 E.02036
G1 X77.299 Y73.462
G1 X76.388 Y72.551 E.02483
G1 X76.021 Y72.742
G1 X76.995 Y73.716 E.02655
G1 X76.716 Y73.995
G1 X75.745 Y73.024 E.02646
G1 X75.548 Y73.385
G1 X76.462 Y74.299 E.02492
G1 X76.216 Y74.61
G1 X75.469 Y73.863 E.02036
; WIPE_START
G1 F12000
M204 S6000
G1 X76.216 Y74.61 E-.40138
G1 X76.462 Y74.299 E-.15082
G1 X76.076 Y73.912 E-.20779
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.149 Y74.707 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0787833
G1 F2947
M204 S6000
G1 X76.097 Y74.77 E.00021
; LINE_WIDTH: 0.10484
G1 X76.063 Y74.785 E.00015
; LINE_WIDTH: 0.165217
G1 X76.028 Y74.8 E.00026
G1 X75.449 Y74.483 E.0045
; WIPE_START
G1 F21000
G1 X76.028 Y74.8 E-.71904
G1 X76.063 Y74.785 E-.04096
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.822 Y72.812 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.171639
G1 F2947
M204 S6000
G1 X77.8 Y73.025 E.00153
; LINE_WIDTH: 0.148886
G1 X77.785 Y73.061 E.00023
; LINE_WIDTH: 0.105961
G1 X77.77 Y73.097 E.00015
; LINE_WIDTH: 0.0787986
G1 X77.707 Y73.149 E.00021
; WIPE_START
G1 F21000
G1 X77.77 Y73.097 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.693 Y74.995 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.376068
G1 F2947
M204 S6000
G1 X75.453 Y75.995 E.01762
M204 S10000
G1 X75.465 Y75.997 F42000
; LINE_WIDTH: 0.267838
G1 F2947
M204 S6000
G1 X75.685 Y74.992 E.01217
M204 S10000
G1 X75.673 Y74.989 F42000
; LINE_WIDTH: 0.169923
G1 F2947
M204 S6000
G1 X75.525 Y75.734 E.00536
; LINE_WIDTH: 0.147157
G1 X75.5 Y75.867 E.0008
; LINE_WIDTH: 0.10286
G1 X75.476 Y75.999 E.00051
; WIPE_START
G1 F21000
G1 X75.5 Y75.867 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X75.476 Y80.001 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.0989246
G1 F2947
M204 S6000
G1 X75.504 Y80.151 E.00055
; LINE_WIDTH: 0.147758
G1 X75.525 Y80.266 E.0007
; LINE_WIDTH: 0.169983
G1 X75.673 Y81.011 E.00536
M204 S10000
G1 X75.686 Y81.007 F42000
; LINE_WIDTH: 0.268731
G1 F2947
M204 S6000
G1 X75.464 Y80.003 E.01222
M204 S10000
G1 X75.453 Y80.022 F42000
; LINE_WIDTH: 0.407711
G1 F2947
M204 S6000
G2 X75.697 Y81.004 I42.269 J-9.964 E.01889
; WIPE_START
G1 F21000
G1 X75.453 Y80.022 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.751 Y83.393 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2947
M204 S2000
G1 X75.609 Y81.251 E.0584
G1 X75.466 Y81.665
G1 X77.332 Y83.531 E.05087
G1 X76.774 Y83.531
G1 X75.474 Y82.231 E.03543
; WIPE_START
G1 F12000
M204 S6000
G1 X76.774 Y83.531 E-.6984
G1 X76.936 Y83.531 E-.0616
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.852 Y83.057 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.212194
G1 F2947
M204 S6000
G1 X77.688 Y82.922 E.00194
; LINE_WIDTH: 0.181022
G1 X77.518 Y82.782 E.00167
; LINE_WIDTH: 0.148352
G1 X77.264 Y82.553 E.00205
; LINE_WIDTH: 0.104889
G1 X76.678 Y81.99 E.00314
; LINE_WIDTH: 0.114718
G1 X76.448 Y81.736 E.00149
; LINE_WIDTH: 0.148685
G1 X76.213 Y81.477 E.0021
; LINE_WIDTH: 0.181725
G1 X76.077 Y81.311 E.00164
; LINE_WIDTH: 0.212865
G1 X75.941 Y81.145 E.00196
; WIPE_START
G1 F21000
G1 X76.077 Y81.311 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X76.392 Y83.462 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.114661
G1 F2947
M204 S6000
G1 X76.287 Y83.386 E.00056
; LINE_WIDTH: 0.143051
G1 X76.182 Y83.311 E.00074
; LINE_WIDTH: 0.184507
G3 X75.691 Y82.821 I1.937 J-2.432 E.00539
; LINE_WIDTH: 0.14449
G1 X75.616 Y82.717 E.00075
; LINE_WIDTH: 0.116073
G1 X75.541 Y82.612 E.00057
; WIPE_START
G1 F21000
G1 X75.616 Y82.717 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X77.989 Y83.327 Z7.56 F42000
G1 Z7.16
G1 E.8 F1800
; LINE_WIDTH: 0.166496
G1 F2947
M204 S6000
G2 X78.867 Y83.5 I7.627 J-36.426 E.00616
; LINE_WIDTH: 0.10286
G1 X78.999 Y83.524 E.00051
M204 S10000
G1 X78.997 Y83.535 F42000
; LINE_WIDTH: 0.267838
G1 F2947
M204 S6000
G1 X77.992 Y83.315 E.01217
M204 S10000
G1 X77.995 Y83.307 F42000
; LINE_WIDTH: 0.376068
G1 F2947
M204 S6000
G1 X78.995 Y83.547 E.01762
; CHANGE_LAYER
; Z_HEIGHT: 7.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X77.995 Y83.307 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 88
M625
; layer num/total_layer_count: 60/73
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
M106 S204
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.56 I-.803 J.915 P1  F42000
G1 X102.533 Y104.84 Z7.56
G1 Z7.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X102.21 Y104.84 E.00623
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.593 Y104.84 E.00765
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14555
G1 X102.21 Y103.223 E-.61445
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.68 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 60 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer60 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.28
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.68 F42000
G1 X85.29 Y104.84 Z7.68
G1 Z7.28
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X84.9 Y92.665 E.217
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
M73 P88 R1
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 61/73
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.68 I-.608 J1.054 P1  F42000
G1 X102.533 Y104.84 Z7.68
G1 Z7.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X102.21 Y104.84 E.00622
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.593 Y104.84 E.00766
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.1454
G1 X102.21 Y103.223 E-.6146
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 61 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer61 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.8 F42000
G1 X85.29 Y104.84 Z7.8
G1 Z7.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X84.9 Y92.665 E.217
; CHANGE_LAYER
; Z_HEIGHT: 7.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 62/73
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.8 I-.608 J1.054 P1  F42000
G1 X102.532 Y104.84 Z7.8
G1 Z7.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X102.21 Y104.84 E.00621
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.592 Y104.84 E.00767
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14526
G1 X102.21 Y103.222 E-.61475
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z7.92 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 62 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer62 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.52
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
M73 P89 R1
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z7.92 F42000
G1 X85.29 Y104.84 Z7.92
G1 Z7.52
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X84.9 Y92.665 E.217
; CHANGE_LAYER
; Z_HEIGHT: 7.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 63/73
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z7.92 I-.608 J1.054 P1  F42000
G1 X102.532 Y104.84 Z7.92
G1 Z7.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X102.21 Y104.84 E.0062
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.592 Y104.84 E.00767
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14511
G1 X102.21 Y103.222 E-.61489
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.04 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 63 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer63 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.64
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z8.04 F42000
G1 X85.29 Y104.84 Z8.04
G1 Z7.64
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X84.9 Y92.665 E.217
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 64/73
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z8.04 I-.608 J1.054 P1  F42000
G1 X102.532 Y104.84 Z8.04
G1 Z7.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X102.21 Y104.84 E.0062
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
M73 P90 R1
G1 X102.592 Y104.84 E.00768
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14497
G1 X102.21 Y103.222 E-.61503
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.16 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 64 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer64 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.76
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z8.16 F42000
G1 X85.29 Y104.84 Z8.16
G1 Z7.76
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X84.9 Y92.665 E.217
; CHANGE_LAYER
; Z_HEIGHT: 7.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 65/73
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z8.16 I-.608 J1.054 P1  F42000
G1 X102.531 Y104.84 Z8.16
G1 Z7.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X102.21 Y104.84 E.00619
G1 X102.21 Y92.46 E.23863
G1 X102.99 Y92.46 E.01504
G1 X102.99 Y104.84 E.23863
G1 X102.591 Y104.84 E.00769
; WIPE_START
G1 F12000
M204 S6000
G1 X102.21 Y104.84 E-.14483
G1 X102.21 Y103.221 E-.61517
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.28 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 65 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer65 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.6 Y104.635
G1 Z7.88
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
G1 X102.6 Y92.665 E.217
; WIPE_START
G1 F21000
G1 X102.6 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X96.02 Y98.532 Z8.28 F42000
G1 X85.29 Y104.84 Z8.28
G1 Z7.88
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01504
G1 X84.51 Y92.46 E.23863
G1 X85.29 Y92.46 E.01504
G1 X85.29 Y104.78 E.23748
M204 S10000
G1 X84.9 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1200
M204 S6000
M73 P91 R1
G1 X84.9 Y92.665 E.217
M106 S255
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X84.9 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M106 S201.45
M625
; layer num/total_layer_count: 66/73
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
M106 S255
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
M204 S10000
G17
G3 Z8.28 I-.59 J1.065 P1  F42000
G1 X102.531 Y104.431 Z8.28
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2904
M204 S6000
G1 X102.183 Y104.431 E.00722
G1 F1788.854
G1 X102.019 Y104.431 E.00339
G1 F960
G1 X102.019 Y92.869 E.23982
G1 F1788.854
G1 X102.183 Y92.869 E.00339
G1 F2904
G1 X102.581 Y92.869 E.00826
G1 X102.581 Y93.269 E.0083
G1 X102.581 Y93.669 E.0083
G1 X102.581 Y94.069 E.0083
G1 X102.581 Y104.421 E.21472
M204 S250
G1 X102.531 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2456.169
M204 S5000
G1 X102.169 Y104.84 E.00697
G1 F600
G1 X101.8 Y104.84 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X101.61 Y104.84 E.00394
G1 X101.61 Y92.46 E.25679
G1 X101.8 Y92.46 E.00394
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X102.169 Y92.46 E.00711
M106 S201.45
M106 S255
G1 F2725.645
G1 X102.569 Y92.46 E.00771
G1 F2904
G1 X102.99 Y92.46 E.00812
G1 X102.99 Y92.86 E.00771
G1 X102.99 Y93.26 E.00771
G1 X102.99 Y104.84 E.22321
G1 X102.591 Y104.84 E.0077
; WIPE_START
G1 F12000
M204 S6000
G1 X102.169 Y104.84 E-.16028
G1 X101.8 Y104.84 E-.14022
G1 X101.61 Y104.84 E-.0722
G1 X101.61 Y103.821 E-.3873
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M106 S201.45
M625
; object ids of layer 66 start: 77
M624 AgAAAAAAAAA=
M106 S255
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer66 end: 77
M106 S201.45
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M106 S255
G1 X102.3 Y104.219
G1 Z8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F2904
M204 S6000
G1 X102.3 Y93.081 E.07476
; WIPE_START
G1 F21000
G1 X102.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.4 I-.585 J-1.067 P1  F42000
G1 X85.234 Y104.431 Z8.4
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2904
M204 S6000
G1 X84.919 Y104.431 E.00652
G1 X84.919 Y94.069 E.21492
G1 X84.919 Y93.669 E.0083
G1 X84.919 Y93.269 E.0083
G1 X84.919 Y92.869 E.0083
G1 X85.318 Y92.869 E.00826
G1 F1788.854
G1 X85.481 Y92.869 E.00339
G1 F960
G1 X85.481 Y104.431 E.23982
G1 F1788.854
G1 X85.318 Y104.431 E.00339
G1 F1931.907
G1 X85.294 Y104.431 E.0005
M204 S250
G1 X85.234 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2904
M204 S5000
G1 X84.51 Y104.84 E.01395
G1 X84.51 Y93.26 E.22321
G1 X84.51 Y92.86 E.00771
G1 X84.51 Y92.46 E.00771
G1 X84.931 Y92.46 E.00812
G1 F2725.645
G1 X85.331 Y92.46 E.00771
G1 F600
G1 X85.7 Y92.46 E.00711
M106 S201.45
M106 S255
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X85.89 Y92.46 E.00394
G1 X85.89 Y104.84 E.25679
M106 S201.45
M106 S255
G1 F1800
G1 X85.7 Y104.84 E.00394
M106 S201.45
M106 S255
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X85.331 Y104.84 E.00711
M106 S201.45
G1 F733.804
G1 X85.294 Y104.84 E.00072
M204 S10000
G1 X85.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F2904
M204 S6000
G1 X85.2 Y93.081 E.07476
; CHANGE_LAYER
; Z_HEIGHT: 8.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X85.2 Y95.081 E-.76
; WIPE_END
M73 P92 R0
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 67/73
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z8.4 I-.578 J1.071 P1  F42000
G1 X102.53 Y104.431 Z8.4
G1 Z8.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1325
M204 S6000
G1 X102.019 Y104.431 E.0106
G1 X102.019 Y92.869 E.23982
G1 X102.581 Y92.869 E.01165
G1 X102.581 Y104.421 E.23961
M204 S250
G1 X102.53 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1325
M204 S5000
G1 X101.61 Y104.84 E.01774
G1 X101.61 Y92.46 E.23863
G1 X102.99 Y92.46 E.0266
G1 X102.99 Y104.84 E.23863
G1 X102.59 Y104.84 E.0077
; WIPE_START
G1 F12000
M204 S6000
G1 X101.61 Y104.84 E-.37256
G1 X101.61 Y103.82 E-.38744
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.52 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 67 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer67 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.3 Y104.219
G1 Z8.12
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F1325
M204 S6000
G1 X102.3 Y93.081 E.07476
; WIPE_START
G1 F21000
G1 X102.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.52 I-.585 J-1.067 P1  F42000
G1 X85.231 Y104.431 Z8.52
G1 Z8.12
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1325
M204 S6000
G1 X84.919 Y104.431 E.00647
G1 X84.919 Y92.869 E.23982
G1 X85.481 Y92.869 E.01165
G1 X85.481 Y104.431 E.23982
G1 X85.291 Y104.431 E.00393
M204 S250
G1 X85.231 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1325
M204 S5000
G1 X84.51 Y104.84 E.0139
G1 X84.51 Y92.46 E.23863
G1 X85.89 Y92.46 E.0266
G1 X85.89 Y104.84 E.23863
G1 X85.291 Y104.84 E.01154
M204 S10000
G1 X85.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F1325
M204 S6000
G1 X85.2 Y93.081 E.07476
; CHANGE_LAYER
; Z_HEIGHT: 8.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X85.2 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 68/73
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z8.52 I-.578 J1.071 P1  F42000
G1 X102.53 Y104.431 Z8.52
G1 Z8.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1325
M204 S6000
G1 X102.019 Y104.431 E.0106
G1 X102.019 Y92.869 E.23982
G1 X102.581 Y92.869 E.01165
G1 X102.581 Y104.421 E.23962
M204 S250
G1 X102.53 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1325
M204 S5000
M73 P93 R0
G1 X101.61 Y104.84 E.01774
G1 X101.61 Y92.46 E.23863
G1 X102.99 Y92.46 E.0266
G1 X102.99 Y104.84 E.23863
G1 X102.59 Y104.84 E.00771
; WIPE_START
G1 F12000
M204 S6000
G1 X101.61 Y104.84 E-.37243
G1 X101.61 Y103.82 E-.38757
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.64 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 68 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer68 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.3 Y104.219
G1 Z8.24
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F1325
M204 S6000
G1 X102.3 Y93.081 E.07476
; WIPE_START
G1 F21000
G1 X102.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.64 I-.585 J-1.067 P1  F42000
G1 X85.229 Y104.431 Z8.64
G1 Z8.24
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1325
M204 S6000
G1 X84.919 Y104.431 E.00643
G1 X84.919 Y92.869 E.23982
G1 X85.481 Y92.869 E.01165
G1 X85.481 Y104.431 E.23982
G1 X85.289 Y104.431 E.00398
M204 S250
G1 X85.229 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1325
M204 S5000
G1 X84.51 Y104.84 E.01386
G1 X84.51 Y92.46 E.23863
G1 X85.89 Y92.46 E.0266
G1 X85.89 Y104.84 E.23863
G1 X85.289 Y104.84 E.01158
M204 S10000
G1 X85.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F1325
M204 S6000
G1 X85.2 Y93.081 E.07476
; CHANGE_LAYER
; Z_HEIGHT: 8.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X85.2 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 69/73
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z8.64 I-.578 J1.071 P1  F42000
G1 X102.53 Y104.431 Z8.64
G1 Z8.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1325
M204 S6000
G1 X102.019 Y104.431 E.01059
G1 X102.019 Y92.869 E.23982
G1 X102.581 Y92.869 E.01165
G1 X102.581 Y104.422 E.23963
M204 S250
G1 X102.53 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1325
M204 S5000
G1 X101.61 Y104.84 E.01773
G1 X101.61 Y92.46 E.23863
G1 X102.99 Y92.46 E.0266
G1 X102.99 Y104.84 E.23863
M73 P94 R0
G1 X102.59 Y104.84 E.00772
; WIPE_START
G1 F12000
M204 S6000
G1 X101.61 Y104.84 E-.37231
G1 X101.61 Y103.82 E-.38769
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.76 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 69 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer69 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.3 Y104.219
G1 Z8.36
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F1325
M204 S6000
G1 X102.3 Y93.081 E.07476
; WIPE_START
G1 F21000
G1 X102.3 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.76 I-.585 J-1.067 P1  F42000
G1 X85.227 Y104.431 Z8.76
G1 Z8.36
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1325
M204 S6000
G1 X84.919 Y104.431 E.00638
G1 X84.919 Y92.869 E.23982
G1 X85.481 Y92.869 E.01165
G1 X85.481 Y104.431 E.23982
G1 X85.287 Y104.431 E.00402
M204 S250
G1 X85.227 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1325
M204 S5000
G1 X84.51 Y104.84 E.01382
G1 X84.51 Y92.46 E.23863
G1 X85.89 Y92.46 E.0266
G1 X85.89 Y104.84 E.23863
G1 X85.287 Y104.84 E.01163
M204 S10000
G1 X85.2 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.163042
G1 F1325
M204 S6000
G1 X85.2 Y93.081 E.07476
; CHANGE_LAYER
; Z_HEIGHT: 8.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F21000
G1 X85.2 Y95.081 E-.76
; WIPE_END
M73 P95 R0
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 70/73
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z8.76 I-.578 J1.071 P1  F42000
G1 X102.529 Y104.431 Z8.76
G1 Z8.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1320
M204 S6000
G1 X102.049 Y104.431 E.00997
G1 X102.049 Y92.869 E.23982
G1 X102.581 Y92.869 E.01104
G1 X102.581 Y104.422 E.23964
M204 S250
G1 X102.529 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1320
M204 S5000
G1 X101.64 Y104.84 E.01715
G1 X101.64 Y92.46 E.23863
G1 X102.99 Y92.46 E.02603
G1 X102.99 Y104.84 E.23863
G1 X102.589 Y104.84 E.00772
; WIPE_START
G1 F12000
M204 S6000
G1 X101.64 Y104.84 E-.36097
G1 X101.64 Y103.79 E-.39903
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z8.88 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 70 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer70 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.315 Y104.219
G1 Z8.48
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.133542
G1 F1320
M204 S6000
G1 X102.315 Y93.081 E.05869
; WIPE_START
G1 F21000
G1 X102.315 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.619 Y98.744 Z8.88 F42000
G1 X85.225 Y104.431 Z8.88
G1 Z8.48
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1320
M204 S6000
G1 X84.919 Y104.431 E.00634
G1 X84.919 Y92.869 E.23982
G1 X85.451 Y92.869 E.01104
G1 X85.451 Y104.431 E.23982
G1 X85.285 Y104.431 E.00345
M204 S250
G1 X85.225 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1320
M204 S5000
G1 X84.51 Y104.84 E.01378
G1 X84.51 Y92.46 E.23863
G1 X85.861 Y92.46 E.02603
G1 X85.861 Y104.84 E.23863
G1 X85.285 Y104.84 E.0111
M204 S10000
G1 X85.185 Y104.219 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.133542
G1 F1320
M204 S6000
G1 X85.185 Y93.081 E.05869
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F21000
G1 X85.185 Y95.081 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 71/73
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
M106 S204
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z8.88 I-.577 J1.071 P1  F42000
G1 X102.529 Y104.431 Z8.88
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1200
M204 S6000
G1 X102.226 Y104.431 E.00629
G1 X102.226 Y92.869 E.23982
G1 X102.581 Y92.869 E.00736
G1 X102.581 Y104.422 E.23964
M204 S250
M73 P96 R0
G1 X102.529 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X101.817 Y104.84 E.01374
G1 X101.817 Y92.46 E.23863
G1 X102.99 Y92.46 E.02262
G1 X102.99 Y104.84 E.23863
G1 X102.589 Y104.84 E.00773
; WIPE_START
G1 F12000
M204 S6000
G1 X101.817 Y104.84 E-.2936
G1 X101.817 Y103.613 E-.4664
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X94.193 Y103.988 Z9 F42000
G1 X85.223 Y104.431 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1200
M204 S6000
G1 X84.919 Y104.431 E.00629
G1 X84.919 Y92.869 E.23982
G1 X85.274 Y92.869 E.00736
G1 X85.274 Y104.422 E.23964
M204 S250
G1 X85.223 Y104.84 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01374
G1 X84.51 Y92.46 E.23863
G1 X85.684 Y92.46 E.02262
G1 X85.684 Y104.84 E.23863
G1 X85.283 Y104.84 E.00773
; WIPE_START
G1 F12000
M204 S6000
G1 X84.51 Y104.84 E-.29363
G1 X84.51 Y103.613 E-.46637
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z9 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 71 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer71 end: 77
M625
; CHANGE_LAYER
; Z_HEIGHT: 8.72
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 72/73
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.529 Y104.84 F42000
G1 Z8.72
G1 E.8 F1800
G1 F1200
M204 S5000
G1 X101.994 Y104.84 E.01032
G1 X101.994 Y92.46 E.23863
G1 X102.99 Y92.46 E.01921
G1 X102.99 Y104.84 E.23863
G1 X102.589 Y104.84 E.00773
; WIPE_START
G1 F12000
M204 S6000
G1 X101.994 Y104.84 E-.22622
G1 X101.994 Y103.435 E-.53378
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z9.12 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 72 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer72 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.492 Y104.635
G1 Z8.72
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.613022
G1 F1200
M204 S6000
G1 X102.492 Y92.665 E.34372
; WIPE_START
G1 F17879.341
G1 X102.492 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.916 Y98.539 Z9.12 F42000
G1 X85.221 Y104.84 Z9.12
G1 Z8.72
M73 P97 R0
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.0137
G1 X84.51 Y92.46 E.23863
G1 X85.507 Y92.46 E.01921
G1 X85.507 Y104.84 E.23863
G1 X85.281 Y104.84 E.00435
M204 S10000
G1 X85.008 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.613022
G1 F1200
M204 S6000
G1 X85.008 Y92.665 E.34372
; CHANGE_LAYER
; Z_HEIGHT: 8.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F17879.341
G1 X85.008 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 77
M625
; layer num/total_layer_count: 73/73
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
; OBJECT_ID: 77
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z9.12 I-.611 J1.052 P1  F42000
G1 X102.529 Y104.84 Z9.12
G1 Z8.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X102.171 Y104.84 E.0069
G1 X102.171 Y92.46 E.23863
G1 X102.99 Y92.46 E.0158
G1 X102.99 Y104.84 E.23863
G1 X102.589 Y104.84 E.00774
; WIPE_START
G1 F12000
M204 S6000
G1 X102.171 Y104.84 E-.15884
G1 X102.171 Y103.258 E-.60116
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z9.24 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
; object ids of layer 73 start: 77
M624 AgAAAAAAAAA=
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; object ids of this layer73 end: 77
M625
; start printing object, unique label id: 77
M624 AgAAAAAAAAA=
G1 X102.58 Y104.635
G1 Z8.84
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.436022
G1 F1200
M204 S6000
G1 X102.58 Y92.665 E.24012
; WIPE_START
G1 F21000
G1 X102.58 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X95.995 Y98.524 Z9.24 F42000
G1 X85.219 Y104.84 Z9.24
G1 Z8.84
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G1 X84.51 Y104.84 E.01366
G1 X84.51 Y92.46 E.23863
G1 X85.33 Y92.46 E.0158
G1 X85.33 Y104.84 E.23863
G1 X85.279 Y104.84 E.00098
M204 S10000
G1 X84.92 Y104.635 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.436022
G1 F1200
M204 S6000
G1 X84.92 Y92.665 E.24012
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F21000
G1 X84.92 Y94.665 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z9.24 I1.217 J0 P1  F42000
; stop printing object, unique label id: 77
M625
M106 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20230428 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z9.34 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos 
G1 Y265 F3000

G1 X65 Y245 F12000
M73 P98 R0
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z108.84 F600
    G1 Z106.84

M400 P100
M17 R ; restore z current

G90
G1 X128 Y250 F3600

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M73 P100 R0
; EXECUTABLE_BLOCK_END

