shader_type spatial;
render_mode cull_disabled; // Disable backface culling to see inside the sphere

uniform sampler2D panorama; // The panoramic texture

void fragment() {
    // Convert from Cartesian (x, y, z) coordinates to spherical coordinates
    float longitude = atan(VERTEX.z, VERTEX.x);
    float latitude = asin(VERTEX.y / length(VERTEX.xyz));

    // Normalize and scale the longitude and latitude to the texture's UV space
    float u = longitude / (2.0 * PI) + 0.5; // Normalize and shift the longitude to fit 0-1 UV space
    float v = latitude / PI + 0.5; // Normalize and shift the latitude to fit 0-1 UV space

    // Flip the image vertically by subtracting v from 1
    v = 1.0 - v;

    // Fetch the texture color using calculated UV coordinates
    vec4 color = texture(panorama, vec2(u, v));
    ALBEDO = color.rgb;
}