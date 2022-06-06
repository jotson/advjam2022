shader_type spatial;
render_mode unshaded;

uniform vec4 color1 : hint_color;
uniform vec4 color2 : hint_color;

void vertex() {
	vec3 v = VERTEX;
	v.x += sin(TIME * 1.3 + float(INSTANCE_ID) + (v.x-0.5)) * v.y * 0.15;
	v.z += sin(TIME * 2.3 + float(INSTANCE_ID) + (v.z-0.5)) * v.y * 0.15;
	VERTEX = v;
}

void fragment() {
	//ALBEDO = mix(color2.rgb, color1.rgb, UV.y * 0.3);
	METALLIC = 0.0;
	ROUGHNESS = 0.7;
	RIM = 1.0;
	RIM_TINT = 0.0;
	//EMISSION = vec3(0.3, 0.3, 0.3) * (1.0-UV.y);
	//ALBEDO = color1.rgb;
}