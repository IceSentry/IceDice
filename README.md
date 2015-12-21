# IceDice
Lua diceroller for teamspeak.

## How to use

Type roll {x}d{y}{+z}
 - x = number of dice to roll
 - y = size of dice
 - z = optional parameters, value to add to the total after the roll

Value that are considered critical (maximum value of the rolled dice) will be written in green.

1's will be written in red.

If someone else in the chat tries to roll their username will be written before writing the result.

### Example roll:

Input: 

`roll 1d6`

Output:
```
rolling 1d6
(4)
= 4
```

Input: 

`roll 10d6`

Output:
```
rolling 10d6
(6 + 2 + 5 + 1 + 3 + 2 + 2 + 6 + 1 + 6)
= 34
```

Input: 

`roll 10d6`

Output:
```
rolling 2d6 + 5
(1 + 2) + 5
= 8
```

## How to install
Download the files and put the IceDice folder in

	C:\Program Files (x86)\TeamSpeak 3 Client\plugins\lua_plugin\
	
In teamspeak:
 - Click settings
 - Choose plugins
 - Select lua plugins
 - Click on settings under the plugin selection window and make sure IceDice is selected
 - Restart teamspeak
