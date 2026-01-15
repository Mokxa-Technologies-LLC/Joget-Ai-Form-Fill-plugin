<style>
/* .container {
display: flex;
align-items: center;
justify-content: space-between;
padding: 10px;
border: 1px solid #ccc;
border-radius: 5px;
background-color: #f9f9f9;
margin-bottom: 20px;
max-width: 100%;
} */
.container {
align-items: center;
justify-content: space-between;
padding: 0px;
border: 1px solid #ccc;
border-radius: 25px;
background-color: #f9f9f9;
width: 53px;
}
.description {
flex-grow: 1;
margin-right: 10px;
font-size: 16px;
color: #333;
}
.error-container {
background-color: #fee;
border: 1px solid #fcc;
color: #c33;
padding: 12px;
border-radius: 4px;
margin: 10px 0;
font-size: 14px;
}
.icon {
display: flex;
align-items: center;
}
.icon img {
height: 40px;
width: 40px;
transition: transform 0.25s ease-in-out;   /* smooth animation */
}
.icon img:hover {
transform: scale(1.15);   /* grows smoothly */
}
</style>
<style>
/* Overlay */
#dialogOverlay {
display: none;
position: fixed;
inset: 0;
background: rgba(0, 0, 0, 0.5);
z-index: 9998;
opacity: 0;
transition: opacity 0.25s ease;
}
/* Dialog */
#dialog {
display: none;
width: 600px;
max-width: 600px;
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%) scale(0.95);
background: #fff;
border-radius: 12px;
padding: 18px;
z-index: 9999;
opacity: 0;
transition:
opacity 0.25s ease,
transform 0.25s ease;
box-sizing: border-box;
}
/* show states */
#dialogOverlay.show {
display: block;
opacity: 1;
}
#dialog.show {
display: block;
opacity: 1;
transform: translate(-50%, -50%) scale(1);
}
/* Segmented control */
.segmented {
margin-bottom: 14px;
}
.segmented-track {
position: relative;
display: flex;
width: 320px;
margin: 0 auto;
padding: 6px;
gap: 8px;
border-radius: 10px;
}
.segmented-btn {
flex: 1;
background: transparent;
border: none;
cursor: pointer;
padding: 8px 10px;
font-size: 14px;
color: #444;
border-radius: 8px;
position: relative;
z-index: 3; /* keep above indicator */
-webkit-appearance: none;
appearance: none;
}
.segmented-btn.active {
color: #fff !important; /* ensure visible over indicator */
font-weight: 600;
outline: none !important;
box-shadow: none !important;
}
/* indicator sits below the buttons */
.segmented-indicator {
position: absolute;
top: 6px;
left: 6px;
height: calc(100% - 12px);
width: calc(50% - 8px);
background: #333;
border-radius: 8px;
z-index: 2;
transition: transform 0.28s ease;
}
/* Content sliding */
.content-viewport {
width: 100%;
min-height: 220px;
overflow: hidden;
}
.content-strip {
display: flex;
width: 200%;
transition: transform 0.28s ease;
}
.tab-section {
width: 50%;
display: flex;
justify-content: center;
box-sizing: border-box;
}
/* Prompt textarea */
#promptInputField {
width: 92%;
height: 200px;
padding: 12px;
border-radius: 8px;
border: 1px solid #ccc;
resize: none;
font-size: 14px;
box-sizing: border-box;
}
/* Drop Zone */
#dropZone {
width: 70%;
max-width: 420px;
height: 90px;
border: 2px dashed #bbb;
border-radius: 10px;
background: #fafafa;
margin-top: 25px;
position: relative;
cursor: pointer;
display: flex;
align-items: center;
justify-content: center;
}
#dropZone input[type="file"] {
position: absolute;
inset: 0;
opacity: 0;
cursor: pointer;
}
.drop-inner {
height: 100%;
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
font-size: 14px;
gap: 5px;
}
.file-name {
color: #333;
}
/* Action Buttons (2 column) */
.dialog-actions {
margin-top: 15px;
display: grid;
grid-template-columns: 1fr 1fr;
gap: 12px;
}
/* Buttons base */
#dialog .dialog-btn {
width: 100%;
padding: 10px 12px;
border-radius: 8px;
border: none;
cursor: pointer;
font-size: 14px;
-webkit-appearance: none;
appearance: none;
box-shadow: none;
}
/* Save = dark grey, Cancel = light grey */
   #dialog .dialog-btn.save-btn {
background: #333;
color: #fff;
}
   #dialog .dialog-btn.cancel-btn {
background: #e6e6e6;
color: #000;
border: 1px solid #d0d0d0;
}
   /* small responsive tweak */
   @media (max-width: 640px) {
#dialog {
width: 94%;
}
.segmented-track {
width: 100%;
}
}
</style>


<!-- mic styling -->
<style>
/* Mic button inside prompt */
.mic-wrap {
position: absolute;
bottom: 14px;
right: 28px;
}

.mic-btn {
width: 42px;
height: 42px;
border-radius: 50%;
border: none;
cursor: pointer;
background: #000;
display: flex;
align-items: center;
justify-content: center;
transition: 0.25s;
}

.mic-btn i {
color: #fff;
font-size: 18px;
}

.mic-btn.listening {
background: #0f9d58;
animation: micPulse 1.4s infinite;
}

@keyframes micPulse {
0% { box-shadow: 0 0 0 0 rgba(15,157,88,0.6); }
70% { box-shadow: 0 0 0 18px rgba(15,157,88,0); }
100% { box-shadow: 0 0 0 0 rgba(15,157,88,0); }
}
</style>

<!-- clear button -->
<style>
/* Clear button */
.clear-btn {
width: 36px;
height: 36px;
border-radius: 50%;
border: none;
cursor: pointer;
background: #e6e6e6;
display: flex;
align-items: center;
justify-content: center;
transition: 0.2s;
}

.clear-btn i {
color: #000;
font-size: 15px;
}

.clear-btn:hover {
background: #d0d0d0;
}

/* mic + clear group */
.mic-wrap {
position: absolute;
bottom: 14px;
right: 24px;
display: flex;
flex-direction: column;   /* 🔹 vertical stack */
align-items: center;      /* 🔹 same center alignment */
gap: 8px;
}
</style>


<!-- Overlay -->
<div id="dialogOverlay"></div>
<!-- Dialog -->
<div id="dialog">
   <!-- Segmented slider tabs -->
   <div class="segmented">
      <div class="segmented-track">
         <button class="segmented-btn active" data-tab="promptSec" type="button">Prompt</button>
         <button class="segmented-btn" data-tab="fileSec" type="button">Upload File</button>
         <div class="segmented-indicator"></div>
      </div>
   </div>
   <!-- Sliding content viewport -->
   <div class="content-viewport">
      <div class="content-strip">
         <!-- Prompt Section -->
         <!-- <div id="promptSec" class="tab-section">
            <textarea id="promptInputField" placeholder="Type your prompt here..."></textarea>
         </div> -->

        <!-- <div id="promptSec" class="tab-section" style="position:relative;">
            <textarea id="promptInputField" placeholder="Type your prompt here..."></textarea>

            <div class="mic-wrap">
                <button type="button" id="micBtn" class="mic-btn">
                    <i id="micIcon" class="fa-solid fa-microphone-slash"></i>
                </button>
            </div>
        </div> -->
        <div id="promptSec" class="tab-section" style="position:relative;">
            <textarea id="promptInputField" placeholder="Type your prompt here..."></textarea>

            <div class="mic-wrap">
                <div class="mic-wrap">
                    <button type="button" id="clearBtn" class="clear-btn" title="Clear text">
                        <i class="fa-solid fa-xmark"></i>
                    </button>

                    <button type="button" id="micBtn" class="mic-btn">
                        <i id="micIcon" class="fa-solid fa-microphone-slash"></i>
                    </button>
                </div>
            </div>
        </div>



         <!-- File Section -->
         <div id="fileSec" class="tab-section">
            <label id="dropZone">
               <input type="file" id="fileUploadField" accept="image/*,.pdf,.txt,.docx" />
               <div class="drop-inner">
                  <div class="drop-text" id="dropText">Click or drag & drop file</div>
                  <div class="file-name" id="fileName" style="display: none"></div>
               </div>
            </label>
         </div>
      </div>
   </div>
   <!-- Action Buttons -->
   <div class="dialog-actions">
      <button type="button" id="dialogSubmitBtnCustom" class="dialog-btn save-btn">Submit</button>
      <button type="button" id="dialogCancelBtnCustom" class="dialog-btn cancel-btn">Cancel</button>
   </div>
</div>
<div class="form-cell" ${elementMetaData!}>
<div class="container">
   <div class="icon">
      <a href="#" id="openDialog">
      <img
         src="${request.contextPath}/plugin/org.joget.mokxa.ContextFormFillElement/chatgpt_logo2.png"
         alt="ChatGPT Icon"
         />
      </a>
   </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.blockUI/2.70/jquery.blockUI.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.16.105/pdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mammoth/1.5.1/mammoth.browser.min.js"></script>
<script>
   async function sendDataToAPI(file) {
$.blockUI({
css: {
border: "none",
padding: "15px",
backgroundColor: "#000",
"-webkit-border-radius": "10px",
"-moz-border-radius": "10px",
opacity: 0.3,
color: "#fff",
},
           message: "<h1>Please wait...</h1>",
       });

       let imageBase64List = [];

       if (file.type === "application/pdf") {
const reader = new FileReader();
reader.readAsArrayBuffer(file);

reader.onload = async function () {
const typedarray = new Uint8Array(this.result);
const pdf = await pdfjsLib.getDocument({
data: typedarray,
}).promise;

               for (let i = 1; i <= pdf.numPages; i++) {
const page = await pdf.getPage(i);
const canvas = document.createElement("canvas");
const context = canvas.getContext("2d");
const viewport = page.getViewport({
scale: 2,
});

                   canvas.width = viewport.width;
                   canvas.height = viewport.height;

                   await page.render({
canvasContext: context,
viewport,
}).promise;
                   const base64String = canvas.toDataURL("image/png");
                   imageBase64List.push(base64String);
               }

               sendForm(imageBase64List); // Send after processing
           };
       } else if (file.type.startsWith("image/")) {
const reader = new FileReader();
reader.readAsDataURL(file);

reader.onload = function (e) {
const img = new Image();
img.src = e.target.result;

img.onload = function () {
const canvas = document.createElement("canvas");
const ctx = canvas.getContext("2d");

canvas.width = img.width;
canvas.height = img.height;
ctx.drawImage(img, 0, 0);

const pngBase64 = canvas.toDataURL("image/png");
imageBase64List = [pngBase64];

sendForm(imageBase64List); // Send after processing
};
           };
       } else if (file.type === "text/plain") {
const reader = new FileReader();
reader.readAsText(file);

reader.onload = function (e) {
const text = e.target.result;

// Create canvas
const canvas = document.createElement("canvas");
const ctx = canvas.getContext("2d");

// Canvas settings
ctx.font = "20px Arial";
const lineHeight = 30;

const lines = text.split("\n");
const maxWidth = Math.max(...lines.map((line) => ctx.measureText(line).width));

canvas.width = maxWidth + 40;
canvas.height = lines.length * lineHeight + 40;

// Background
ctx.fillStyle = "#FFFFFF";
ctx.fillRect(0, 0, canvas.width, canvas.height);

// Draw lines
ctx.fillStyle = "#000000";
let y = 30;
lines.forEach((line) => {
ctx.fillText(line, 20, y);
y += lineHeight;
});
               const pngBase64 = canvas.toDataURL("image/png");
               sendForm([pngBase64]);
           };
       } else if (file.type === "application/vnd.openxmlformats-officedocument.wordprocessingml.document") {
const reader = new FileReader();
reader.readAsArrayBuffer(file);

reader.onload = async function (e) {
const arrayBuffer = e.target.result;

const result = await mammoth.extractRawText({
arrayBuffer,
});
               const text = result.value;

               // Create canvas for image conversion
               const canvas = document.createElement("canvas");
               const ctx = canvas.getContext("2d");

               ctx.font = "20px Arial";
               const lineHeight = 28;

               const lines = text.split("\n");
               const maxWidth = Math.max(...lines.map((line) => ctx.measureText(line).width));

               canvas.width = maxWidth + 60;
               canvas.height = lines.length * lineHeight + 60;

               // Background white
               ctx.fillStyle = "#FFFFFF";
               ctx.fillRect(0, 0, canvas.width, canvas.height);

               ctx.fillStyle = "#000000";

               let y = 40;
               lines.forEach((line) => {
ctx.fillText(line, 30, y);
y += lineHeight;
});

               const pngBase64 = canvas.toDataURL("image/png");

               sendForm([pngBase64]);
           };
       }
       console.log(imageBase64List);
   }

   function sendForm(imageBase64List) {
const formData = new FormData();
formData.append("imageBase64List", JSON.stringify(imageBase64List));

$.ajax({
url: "${element.serviceUrl!}",
method: "POST",
data: formData,
contentType: false, // Important for file upload
processData: false, // Important for FormData
success: function (response) {
if (response && typeof response === "object") {
response.content = JSON.parse(response.content);
if (Array.isArray(response.content)) {
clearForm(response.content);
populateForm(response.content);
} else {
console.error("Response elements is not an array:", response.content);
response.content = [response.content];
}
               } else {
console.error("Invalid response object:", response);
}
               $.unblockUI();
           },
           error: function (xhr, status, error) {
console.error("API call failed:", status, error);
$.unblockUI();
alert("Upload failed. \nPlease contact your administrator for assistance.");
},
       });
   }

   /**
    * Remove existing inputs in a form.
    * @param elements - Elements in the form
    */
   function clearForm(elements) {
for (let i = 0; i < elements.length; i++) {
const elementId = elements[i].id;
const elementType = elements[i].type;
switch (elementType) {
case "TextField":
case "TextArea":
$("#" + elementId).val("");
break;
case "DatePicker":
const $datePicker = $('input[name="' + elementId + '"]');
$datePicker.val("").trigger("change");
break;
case "Radio":
case "CheckBox":
$('input[name="' + elementId + '"]').prop("checked", false);
break;
case "SelectBox":
$('select[name="' + elementId + '"]').val("");
break;
case "Grid":
const $container = $("#" + elementId);
const $table = $container.find("table");
const $tbody = $table.find("tbody");

$tbody.children(":not(.grid-row-template)").remove(); // Remove everything except the template
break;
default:
}
       }
   }

   /**
    * Populate form.
    * @param elements - Elements containing data to be populated in form
    */
   function populateForm(elements) {
elements.forEach(function (element) {
const elementId = element.id;
const elementValue = element.value;
const elementType = element.type;
switch (elementType) {
case "TextField":
case "TextArea":
$("#" + elementId).val(elementValue);
break;
case "DatePicker":
const $datePicker = $('input[name="' + elementId + '"]');
$datePicker.val(elementValue).trigger("change");
break;
case "Radio":
$('input[name="' + elementId + '"][value="' + elementValue + '"]').prop("checked", true);
break;
case "CheckBox":
elementValue.forEach((option) => {
$('input[name="' + elementId + '"][value="' + option + '"]').prop("checked", true);
});
                   break;
               case "SelectBox":
                   $('select[name="' + elementId + '"]').val(elementValue);
                   break;
               case "Grid":
                   const $container = $("#" + elementId);
                   const $addRow = $container.find(".grid-row-add");
                   const $table = $container.find("table");
                   const $tbody = $table.find("tbody");
                   const columns = element.availableOptions;

                   elementValue.forEach((row, index) => {
// trigger add row event
$addRow.trigger("click");
const $newRow = $tbody.find(".grid-row").last();
// fill data for each column
columns.forEach((column) => {
const data = row[column];
if (data !== "") {
$newRow.find(".grid-cell[name='" + elementId + "_" + column + "']").text(data);
$newRow
.find(".grid-input[name='" + elementId + "_" + column + "_" + index + "']")
.val(data);
}
                       });
                   });
                   break;
               default:
                   console.warn("Unknown element type:", elementType);
           }
       });
   }

   function handlePromptSubmit(prompt) {
console.log("Custom Prompt Handler:", prompt);
$.blockUI({
css: {
border: "none",
padding: "15px",
backgroundColor: "#000",
"-webkit-border-radius": "10px",
"-moz-border-radius": "10px",
opacity: 0.3,
color: "#fff",
},
           message: "<h1>Please wait...</h1>",
       });
       // Create canvas
       const canvas = document.createElement("canvas");
       const ctx = canvas.getContext("2d");

       // Canvas settings
       ctx.font = "20px Arial";
       const lineHeight = 30;

       const lines = prompt.split("\n");
       const maxWidth = Math.max(...lines.map((line) => ctx.measureText(line).width));

       canvas.width = maxWidth + 40;
       canvas.height = lines.length * lineHeight + 40;

       // Background
       ctx.fillStyle = "#FFFFFF";
       ctx.fillRect(0, 0, canvas.width, canvas.height);

       // Draw lines
       ctx.fillStyle = "#000000";
       let y = 30;
       lines.forEach((line) => {
ctx.fillText(line, 20, y);
y += lineHeight;
});
       const pngBase64 = canvas.toDataURL("image/png");
       console.log([pngBase64]);
       sendForm([pngBase64]);
   }
</script>
<script>
   $(document).ready(function () {
/* Open dialog */
$("#openDialog").on("click", function (e) {
e.preventDefault();
$("#dialogOverlay, #dialog").show();
setTimeout(() => {
$("#dialogOverlay").addClass("show");
$("#dialog").addClass("show");
}, 10);

           // ensure indicator positioned
           moveIndicatorTo($(".segmented-btn.active"));
       });

       /* Close dialog */
       $("#dialogCancelBtnCustom, #dialogOverlay").on("click", function () {
stopMicIfRunning();
$("#dialogOverlay, #dialog").removeClass("show");
setTimeout(() => $("#dialogOverlay, #dialog").hide(), 250);
});

       /* Segmented tab switching */
       $(".segmented-btn").on("click", function () {
var $btn = $(this);
if ($btn.hasClass("active")) return;

$(".segmented-btn").removeClass("active");
$btn.addClass("active");

moveIndicatorTo($btn);

const tab = $btn.data("tab");
if (tab === "promptSec") {
$(".content-strip").css("transform", "translateX(0)");
} else {
stopMicIfRunning();
$(".content-strip").css("transform", "translateX(-50%)");
}
       });

       function moveIndicatorTo($btn) {
const index = $(".segmented-btn").index($btn);
// translate by index * 100% of one slot; since indicator width = 50% - padding, translate by 100% increments
$(".segmented-indicator").css("transform", "translateX(" + (index * 100) + "%)");
}

       /* File handling */
       const $drop = $("#dropZone");
       const $fileInput = $("#fileUploadField");
       const $dropText = $("#dropText");
       const $fileName = $("#fileName");

       // drag events: highlight border
       $drop.on("dragenter dragover", function (e) {
e.preventDefault();
e.stopPropagation();
$(this).css("border-color", "#888");
});

       $drop.on("dragleave", function (e) {
e.preventDefault();
e.stopPropagation();
$(this).css("border-color", "#bbb");
});

       // drop event
       $drop.on("drop", function (e) {
e.preventDefault();
e.stopPropagation();
$(this).css("border-color", "#bbb");
const dt = e.originalEvent.dataTransfer;
if (dt && dt.files && dt.files.length) {
$fileInput[0].files = dt.files;
handleFileSelection(dt.files[0]);
}
       });

       // file picker change
       $fileInput.on("change", function () {
const f = this.files && this.files[0];
if (f) handleFileSelection(f);
});

       function handleFileSelection(file) {
$dropText.hide();
$fileName.text(file.name).show();
console.log("File selected:", file);
}

       /* Save action */
       $("#dialogSubmitBtnCustom").on("click", function () {
stopMicIfRunning();
event.preventDefault();
event.stopPropagation();

const activeTab = $(".segmented-btn.active").data("tab");
if (activeTab === "promptSec") {
let text = $("#promptInputField").val().trim();
if (!text) {
alert("Enter prompt");
return;
}
               handlePromptSubmit(text);
               console.log("Prompt submitted:", text);
           } else {
const f = $fileInput[0].files && $fileInput[0].files[0];
if (!f) {
alert("Select file");
return;
}
               const MAX_FILE_SIZE_MB = 2;
               const MAX_FILE_SIZE_BYTES = MAX_FILE_SIZE_MB * 1024 * 1024;

               if (f && f.size > MAX_FILE_SIZE_BYTES) {
alert(
"The file size is too big. Please upload a file which is less than " +
MAX_FILE_SIZE_MB +
"MB in size."
);
return;
}

               sendDataToAPI(f); // Call API after file selection
               console.log("File ready:", f.name);
           }
           // close
           $("#dialogCancelBtnCustom").click();
       });

       /* keep indicator on resize */
       $(window).on("resize", function () {
moveIndicatorTo($(".segmented-btn.active"));
});

       // set initial state: ensure active button has proper z-index and indicator positioned
       moveIndicatorTo($(".segmented-btn.active"));
   });
</script>
</div>
<!-- Dialog HTML -->


<!-- script for Speech Recognization -->
<script>
(function () {
let lastFinalIndex = -1;
const isMobile = /Android|iPhone|iPad|iPod/i.test(navigator.userAgent);

const SpeechRecognition =
window.SpeechRecognition || window.webkitSpeechRecognition;

if (!SpeechRecognition) {
console.warn("Speech API not supported");
return;
}

    const recognition = new SpeechRecognition();
    recognition.lang = "en-US";   // change to hi-IN if needed
    recognition.interimResults = true;
    recognition.continuous = !isMobile; //  mobile-safe

    let listening = false;
    let finalText = "";


    const $micBtn = $("#micBtn");
    const $micIcon = $("#micIcon");
    const $textarea = $("#promptInputField");

    $micBtn.on("click", function () {
if (!listening) {
lastFinalIndex = -1;
finalText = $textarea.val().trim();
if (finalText) finalText += " ";

recognition.start();
listening = true;

$micBtn.addClass("listening");
$micIcon
.removeClass("fa-microphone-slash")
.addClass("fa-microphone");

} else {
recognition.stop();
listening = false;

$micBtn.removeClass("listening");
$micIcon
.removeClass("fa-microphone")
.addClass("fa-microphone-slash");
}
    });

    // recognition.onresult = function (event) {
//     let interim = "";

//     for (let i = event.resultIndex; i < event.results.length; i++) {
//         const text = event.results[i][0].transcript;
//         if (event.results[i].isFinal) {
//             finalText += text + " ";
//         } else {
//             interim += text;
//         }
    //     }

    //     $textarea.val(finalText + interim);
    // };

    recognition.onresult = function (event) {
let interim = "";

for (let i = event.resultIndex; i < event.results.length; i++) {
const result = event.results[i];
const text = result[0].transcript.trim();

if (result.isFinal) {
// 🔹 Prevent duplicate final results (mobile fix)
if (i > lastFinalIndex) {
finalText += text + " ";
lastFinalIndex = i;
}
            } else {
interim += text + " ";
}
        }

        $textarea.val(finalText + interim);
    };


    // recognition.onend = function () {
//     if (listening) recognition.start(); // YouTube-style auto resume
// };

    recognition.onend = function () {
listening = false;

$micBtn.removeClass("listening");
$micIcon
.removeClass("fa-microphone")
.addClass("fa-microphone-slash");
};

    recognition.onerror = function (e) {
console.error("Speech error:", e.error);
};


    const $clearBtn = $("#clearBtn");
    $clearBtn.on("click", function () {


// if mic is active, stop it
if (listening) {
recognition.stop();
listening = false;

$micBtn.removeClass("listening");
$micIcon
.removeClass("fa-microphone")
.addClass("fa-microphone-slash");
}

        $textarea.val("");
        finalText = "";

    });

    window.stopMicIfRunning = function () {
if (!listening) return;

listening = false;
recognition.onend = null;
recognition.stop();

$micBtn.removeClass("listening");
$micIcon
.removeClass("fa-microphone")
.addClass("fa-microphone-slash");
};
})();
</script>




