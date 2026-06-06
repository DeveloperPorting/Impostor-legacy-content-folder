#pragma header

uniform mat4 colorMatrix;

uniform vec4 colorOffset;

void main()
{
	vec4 baseColor = texture2D(bitmap, openfl_TextureCoordv);

	if (baseColor.a == 0.0) {
		gl_FragColor = baseColor;
		return;
	}

	vec4 finalColor = colorMatrix * baseColor + colorOffset;

	finalColor.a = baseColor.a;

	gl_FragColor = clamp(finalColor, 0.0, 1.0);
}