shader_type spatial;

render_mode unshaded;

uniform vec3 ping_origin;
uniform float ping_time = -1000.0;

uniform float wave_speed = 5.0;
uniform float wave_width = 0.5;

void fragment() {
    vec3 world_pos = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    float dist = distance(ping_origin, world_pos);

    float wave_front = (TIME - ping_time) * wave_speed;
    float dist_to_wave = abs(dist - wave_front);

    float signal = 1.0 - smoothstep(0.0, wave_width, dist_to_wave);

    ALBEDO = vec3(signal);
    EMISSION = vec3(signal);
}
