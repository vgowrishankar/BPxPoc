import pyautogui
from selenium import webdriver
from selenium.webdriver import ActionChains
from pynput.keyboard    import  Key, Controller
import time


def minwindow():

    print("calles python function")

    for i in range   (1,3):
        pyautogui.keyDown('ctrl')
        pyautogui.keyDown('-')
        pyautogui.keyUp('ctrl')
        pyautogui.keyUp('-')

def Upload_files(file_path:str):
    time.sleep(4)
    keyword=Controller()
    #sample file path C:\\filename
    keyword.type(file_path)
    keyword.press(Key.enter)
    keyword.release(Key.enter)
    time.sleep(3)



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

path = r'"C:\\Users\\10712370\\PycharmProjects\\pythonProject\\BPxPoc\\Resources\\Portal\\Keywords\\template_01.docx"'

def drag_and_drop_file(drop_target):
    driver = drop_target.parent
    file_input = driver.execute_script(JS_DROP_FILE, drop_target, 0, 0)
    file_input.send_keys(path)

#driver = webdriver.chrome(executable_path="../../../Drivers/chromedriver.exe")

#def Drag_drop_using_actionChain(drag,drop):
   # actions = ActionChains(driver)
  #  actions.drag_and_drop(drag,drop).perform()

