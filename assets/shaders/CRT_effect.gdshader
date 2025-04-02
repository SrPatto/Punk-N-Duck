shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture; // Nueva forma de declarar SCREEN_TEXTURE
uniform float curvature : hint_range(0.0, 1.0) = 0.1; // Curvatura de la pantalla
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.5; // Intensidad de las líneas de escaneo
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.3; // Fuerza del viñeteado
uniform vec2 resolution; // Resolución base (se debe configurar desde script o editor)

void fragment() {
    // Coordenadas normalizadas de la pantalla
    vec2 uv = SCREEN_UV;
    vec2 center = vec2(0.5, 0.5);

    // Curvatura de la pantalla
    vec2 offset = uv - center;
    float dist = length(offset);
    uv += offset * dist * curvature;

    // Líneas de escaneo
    float scanline = sin(uv.y * resolution.y * 2.0) * scanline_intensity;
    vec3 color = texture(screen_texture, uv).rgb; // Usamos el nuevo uniform screen_texture
    color -= scanline;

    // Viñeteado
    float vignette = smoothstep(0.8, 0.5, dist) * vignette_strength;
    color *= (1.0 - vignette);

    COLOR = vec4(color, 1.0);
}
