# AONS-ENSU
 A batch file tool to automate the process of updating old ONScripter-EN executables. 
 
 ## Usage:
 ### Overview
 Example call
 
 ```AONS-ENSU <game-folder-path> <game-name>```
 
 A couple of quick notes. 
 - You can have spaces in the ```game-name```, you cannot have spaces in the ```game-folder-path```.
 - Don't put ```AONS-ENSU.bat``` in a system protected folder.
 - ```AONS-ENSU``` needs a ```zip.txt``` file in the same directory to work. ```zip.txt``` should only contain the name of the ```.zip``` file that contains the updated executable, extension included.

 ### Step-by-step instructions
 If you didn't understand the overview, here is a set of step by step instructions to set up and use AONS-ENSU.
 
 1. Download the AONS-ENSU.bat, and move it to a folder inside your ```Documents``` folder (example: ```C:\Users\RaspberryLime\Documents\VN\AONS-ENSU```) The name of this folder, and any folders it is inside of, *cannot contain any spaces.* (allowed:```C:\Users\RaspberryLime\Documents\VN\AONS-ENSU```. Not allowed: ```C:\Users\Raspberry Lime\Documents\VN\AONS-ENSU```)
 2. Move your chosen .zip file to the same folder (```C:\Users\RaspberryLime\Documents\VN\AONS-ENSU```)
 3. Copy the name of the .zip file you've chosen (example: ```onscripter-en-20240721.Windows.x86-64.zip```)
 4. Press ```Ctrl + r```, type ```cmd```, and hit enter.
 5. Move into the AONS-ENSU folder by typing ```cd C:\Users\RaspberryLime\Documents\VN\AONS-ENSU``` and pressing enter.
 6. Press type ```echo ```, press ```Ctrl + v```, type ```>ziptxt``` and finally, hit enter. You should have typed and entered this command: ```echo onscripter-en-20240721.Windows.x86-64.zip>zip.txt```.
 7. Call the batch file as shown below. If the game name has spaces in it, surround it with quotes. For example, A Midsummer Day's Resonance becomes "A Midsummer Day's Resonance".
 ![AONS-ENSU usage](https://github.com/RaspberryLime123/AONS-ENSU/assets/114409092/2bb18052-d456-4f7b-aa1d-794125ec6f51)

 A BIG THANKS to chaoskaiser72 for helping me with this project, and for hosting a link on his website, which you should check out if you haven't already.
 
 if have something to say, or want to talk visual novels, shoot me an email: raspberrylime123@gmail.com
