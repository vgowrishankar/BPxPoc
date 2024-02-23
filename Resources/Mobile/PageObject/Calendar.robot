*** Variables ***
${next_page}    //android.widget.ImageButton[@content-desc="next page"]
${ok_button}    //android.widget.Button[@resource-id="com.google.android.calendar:id/oobe_done_button"]
${AddTaskOrEvent}    //android.widget.ImageButton[@content-desc="Create new event or other calendar entries"]
${AddEvent}    //android.widget.FrameLayout[@resource-id="com.google.android.calendar:id/speed_dial_event_container"]
${AddTask}     //android.widget.FrameLayout[@resource-id="com.google.android.calendar:id/tasks_speed_dial_container"]
${Title}    //android.widget.EditText[@resource-id="com.google.android.calendar:id/title"]
${EnableSwitch}    //android.widget.Switch
${DoesNotReport}    //android.widget.TextView[@resource-id="com.google.android.calendar:id/first_line_text" and @text="Does not repeat"]
${AddLocation}    //android.widget.TextView[@resource-id="com.google.android.calendar:id/first_line_text" and @text="Add location"]
${AllowLocation}    //android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_one_time_button"]
${InputLocation}    //android.widget.EditText[@resource-id="com.google.android.calendar:id/search_text"]
${SelectEnteredLocation}    //android.widget.TextView[@resource-id="com.google.android.calendar:id/first_line_text" and @text="Denver, CO"]
${SaveButton}    //android.widget.Button[@resource-id="com.google.android.calendar:id/save"]
${EveryDay}      //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Every day"]
${EveryWeek}     //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Every week"]
${EveryMonth}    //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Every month"]
${EveryYear}     //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Every year"]
${Custom}        //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Custom…"]

