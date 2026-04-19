shader_type canvas_item;

uniform vec2 tiled_factor = vec2(0.5, 0.5);
uniform float aspecet_ratio = 1;

varying vec4 vertex_color; 

void vertex() {
	vertex_color = COLOR;
}

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspecet_ratio;
	
	vec2 waves_uv_offset;
	waves_uv_offset.x = cos(TIME + (tiled_uvs.x + tiled_uvs.y) * 2.0) * 0.02;
	waves_uv_offset.y = sin(TIME + (tiled_uvs.x + tiled_uvs.y)) * 0.02;
	
	vec4 color = texture(TEXTURE, tiled_uvs + waves_uv_offset);
	COLOR = vertex_color * color;
}

void light() {
  //float cNdotL = max(0.0, dot(NORMAL, LIGHT_DIRECTION));
  LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY, LIGHT_COLOR.a);
}