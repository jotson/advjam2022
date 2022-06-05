shader_type spatial;
render_mode unshaded;

void vertex() {
	vec3 v = VERTEX;
	v.x += sin(TIME + float(INSTANCE_ID)) * v.y * 0.1;
	v.z += sin(TIME + float(INSTANCE_ID) * 3.0) * v.y * 0.1;
	VERTEX = v;
}