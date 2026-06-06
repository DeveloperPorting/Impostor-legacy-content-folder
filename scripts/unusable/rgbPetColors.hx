import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxRuntimeShader;

// hi this is kim, this script was made by ASHLEY and edited by LOGGO and ORBYY, thank you!
var petRGB:FlxRuntimeShader = null;

/**
    * Since the RGB pets default to Boyfriend's health icon color, some colors (like yellowplayable and amongbf) would be ugly/inaccurate to how they are in Among Us. 
    - This is how it works:
    ```haxe
    "skinname" => [lightercolor, darkercolor]
    ```
**/
var overwriteColors:Map<String, Array<FlxColor>> = [
    'amongbf' => [0x66FFFF, 0x50A5EB],
    'redp' => [0xFFFD132B, 0xFF700E4A],
	'greenp' => [0xFF1E4824, 0xFF00221F],
	'yellowplayable' => [0xFFFFD452, 0xFFE0893B],
	'whitep' => [0xFFE9E4F4, 0xFF7278B6],
	'blackp' => [0xFF381B51, 0xFF200A1E],
	'maroonplayable' => [0xFF6B2B3C, 0xFF440D37],
	'pinkplayable' => [0xFFFD42AD, 0xFF9E01B9],
	'fall-guy' => [0xFFFF6699, 0xFFCC3399],
	'minigrey' => [0xFF59587A, 0xFF282C4F],
	'LIMEGREENPlayable' => [0xFF66FF65, 0xFF009A65],
	'tuesdayplayable' => [0xFFFF6770, 0xFFC6377B],
	'chefplayable' => [0xFFFF8E38, 0xFFFB4C3D],
    'whitewho' => [0xFFFF9933, 0xFFFF4040],
    'whitemad' => [0xFFFF9933, 0xFFFF4040],
    'dripbf' => [0xFF9933FF, 0xFF3E35B1],
    'pip' => [0xFFFF3535, 0xFF8A1843],
    'pip_evil' => [0xFFFF3535, 0xFF8A1843],
    'pretender' => [0xFFE64499, 0xFF760386],
];
/**
    * The pets that support RGB. This should only be applied to ones with only RGB colors.
    - Because it's funny, making it null or empty will result in it being on for all pets.
**/
var rgbPets:Array<String> = ['rgbpet', 'rudie'];

/**
    * The variable that checks if `rgbPets` contains `pet.curPet`
**/
var hasRGBpet:Bool = false;

function onCreatePost()
{
    hasRGBpet = (rgbPets.length == 0 || rgbPets == null || rgbPets.contains(pet.curPet));
    if (!hasRGBpet) return; // WHAT DO YOU MEAN WE DONT EVEN HAVE AN RGB PET ON
    
    var frag:String = Paths.getTextFromFile('shaders/rgb.frag');
    petRGB = new FlxRuntimeShader(frag);
    petRGB.setFloatArray('green', [96 / 255, 208 / 255, 1]);
    petRGB.setFloat('visor', 1);
    petRGB.setFloat('opacity', 1);
    pet.shader = petRGB;
    updateRGB(boyfriend);
}
/**
    * converts `FlxColor` into an array of `R, G, B` divided by 255 for the shader support
**/
function convertColor(col:FlxColor = 0xFFFFFF):Array<Float> {
    var colorArray:Array<Float> = [
        FlxColor.getRed(col) / 255,
        FlxColor.getGreen(col) / 255,
        FlxColor.getBlue(col) / 255
    ];
    return colorArray;
}
/**
    * Reloads the color shader depending on `based.healthColour`
    ```haxe
    updateRGB(boyfriend);
    ```
**/
function updateRGB(?based:Character = boyfriend) {
    if(overwriteColors.exists(based.curCharacter))
    {
        // if it has handmade colors assigned to it, get them from the map.
        var color:Array<FlxColor> = overwriteColors.get(boyfriend.curCharacter);
        petRGB.setFloatArray('red', convertColor(color[0]));
        petRGB.setFloatArray('blue', convertColor(color[1]));
    } else {
        // else, we just automate it.
        var color:FlxColor = convertColor(based.healthColour);
        petRGB.setFloatArray('red', color);
        petRGB.setFloatArray('blue', [color[0]/2, color[1]/2, color[2] / 2 + 0.2]);
    }
}