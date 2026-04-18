shader_type spatial;

render_mode unshaded;

uniform vec3 ping_origin;
uniform float ping_time = -1000.0;

uniform float wave_speed = 5.0;
uniform float wave_width = 0.5;

uniform float debug = 1.0;

void fragment() {
    vec3 world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    vec3 world_normal = mat3(INV_VIEW_MATRIX) * NORMAL;

    float dist = distance(ping_origin, world_pos);

    float wave_front = (TIME - ping_time) * wave_speed;
    float dist_to_wave = abs(dist - wave_front);

    float signal = 1.0 - smoothstep(0.0, wave_width, dist_to_wave);
	vec3 debug_color = vec3(0.5) + 0.5 * world_normal;

    ALBEDO = mix(vec3(signal), debug_color, debug);
    EMISSION = mix(vec3(signal), debug_color, debug);
}
