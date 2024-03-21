// Resident Evil Revelations 2 Autosplitter Version 1.0.7 08/11/2021
// Supports LRT
// Supports all difficulties & campaigns
// Script & Pointers by TheDementedSalad
// Thanks to Mysterion06 for helping whenever I had questions and needed help!

state("rerev2")
{
	uint p1hp : 0x1167EAC, 0x20, 0x1A08;
	uint p2hp : 0x1167EAC, 0x24, 0x1A08;
    float p1stam : 0x117EE60, 0x84, 0x8, 0x1604, 0x8;
	float p2stam : 0x117EE60, 0x88, 0x8, 0x1604, 0x8;
    float p1breath : 0x117EE60, 0x84, 0x8, 0x1604, 0xBC;
	float p2breath : 0x117EE60, 0x88, 0x8, 0x1604, 0xBC;

	byte inLoading : 0x1102BB4;
	float IGT : 0x117D120, 0x1403F4;
	byte inGame : 0x1152A10, 0x380;
	byte inMenu : 0x117AE00, 0x34;
	byte Cutscene : 0x1162E10, 0x54C;
	byte areaNo: 0x117D120, 0x140380;
	byte inGameCS: 0x1162E10, 0x54C;
	byte gameState: 0x117E4C8, 0x168, 0x3C, 0x8;
	byte chapEnd: 0x1134480, 0x60, 0x8258;
	byte Paused:	0x11DE768, 0x1698;
}

startup
{				
	settings.Add("Full", false, "Full Game & DLC");
	settings.Add("Claire", false, "Claire Only");
	settings.Add("Barry", false, "Barry Only");
	
}

start
{
	if(current.inGameCS == 0 && old.inGameCS == 1 || current.areaNo == 201 && current.inLoading == 1 && current.inGame == 1 && current.inMenu != 0){
		return true;
	}
}

split
{
	if(settings["Full"] || settings["Claire"] || settings["Barry"]){
	if (current.chapEnd == 3 && current.inMenu == 1){
		return true;
		}
	}
}
	
isLoading
{	
	if(current.inLoading != 1 || current.inGameCS == 1 || current.gameState != 4 || current.chapEnd == 3 || current.Paused == 2 || current.Paused == 4 || current.Cutscene == 1){
		return true;
	}
	else{
		return false;
	}
}

reset
{
	if(settings["Full"]){
		if(current.areaNo == 100 && old.inMenu == 0 && current.inMenu == 1){
            return true;
        }
	}
	if(settings["Claire"]){
		if((current.areaNo == 100 || current.areaNo == 88 || current.areaNo == 188 || current.areaNo == 40) && old.inMenu == 0 && current.inMenu == 1){
            return true;
        }
	}
	if(settings["Barry"]){
		if(current.areaNo == 153 && old.inMenu == 0 && current.inMenu == 1){
			return true;
		}
	}
}
