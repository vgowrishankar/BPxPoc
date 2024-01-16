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

JS_DROP_FILE = """
    var target = arguments[0],
        offsetX = arguments[1],
        offsetY = arguments[2],
        document = target.ownerDocument || document,
        window = document.defaultView || window;

    var input = document.createElement('INPUT');
    input.type = 'file';
    input.onchange = function () {
      var rect = target.getBoundingClientRect(),
          x = rect.left + (offsetX || (rect.width >> 1)),
          y = rect.top + (offsetY || (rect.height >> 1)),
          dataTransfer = { files: this.files };

      ['dragenter', 'dragover', 'drop'].forEach(function (name) {
        var evt = document.createEvent('MouseEvent');
        evt.initMouseEvent(name, !0, !0, window, 0, 0, 0, x, y, !1, !1, !1, !1, 0, null);
        evt.dataTransfer = dataTransfer;
        target.dispatchEvent(evt);
      });

      setTimeout(function () { document.body.removeChild(input); }, 25);
    };
    document.body.appendChild(input);
    return input;
"""

def drag_and_drop_file(drop_target, path):

    driver = drop_target.parent
    file_input = driver.execute_script(JS_DROP_FILE, drop_target, 0, 0)
    file_input.send_keys(path)