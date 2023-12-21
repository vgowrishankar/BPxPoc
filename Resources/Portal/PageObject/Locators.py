# Data Portal locators
import pyautogui
from robot.api.deco import keyword, library

# Data Portal Pads locators
Padname = "id:padname"
Padid = "id:padid"
Businessunit = "id:businessunit"

# Data Portal Well Origins locators
WellName = "id:wellname"
UploadUrl = "id:btnUploadUrl"

# Data Portal Well bores locators
OrginCorpID = "id:origincorpid"

# Data Portal Completions locators
CompletioID = "id:completionid"

# Data Portal Refresh locators
RefreshTable = "id:RefreshTable"
__version__ = "6.2.0"


def minwindow():

     print("calles python function")
     pyautogui.keyDown('ctrl')
     pyautogui.keyDown('-')
     pyautogui.keyUp('ctrl')
     pyautogui.keyUp('-')
     pyautogui.keyDown('ctrl')
     pyautogui.keyDown('-')
     pyautogui.keyUp('ctrl')
     pyautogui.keyUp('-')
     pyautogui.keyDown('ctrl')
     pyautogui.keyDown('-')
     pyautogui.keyUp('ctrl')
     pyautogui.keyUp('-')
