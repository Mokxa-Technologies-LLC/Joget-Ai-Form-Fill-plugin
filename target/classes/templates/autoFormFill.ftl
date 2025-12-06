 <style>
    .container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f9f9f9;
        margin-bottom: 20px;
        max-width: 100%;
    }
    .description {
        flex-grow: 1;
        margin-right: 10px;
        font-size: 16px;
        color: #333;
    }
    .icon {
        display: flex;
        align-items: center;
    }
    .icon img {
        height: 50px;
        width: 50px;
    }
</style>
<div class="form-cell" ${elementMetaData!}>
    <div class="container">
        <div class="description">
            Click the icon on the right to auto-fill the form using GPT.
        </div>
        <div class="icon">
            <a href="#" id="apiCallLink">
                <img src="${request.contextPath}/plugin/org.joget.ai.form_fill_element.AutoFormFillElement/chatgpt_logo.png" alt="ChatGPT Icon"/>
            </a>
        </div>
    </div>
</div>


<script>
    $(document).ready(function() {
    $('#apiCallLink').on('click', function(event) {
        event.preventDefault();
        event.stopPropagation();

        $.blockUI({ css: { 
            border: 'none', 
            padding: '15px', 
            backgroundColor: '#000', 
            '-webkit-border-radius': '10px', 
            '-moz-border-radius': '10px', 
            opacity: .3, 
            color: '#fff' 
        }, message : "<h1>Please wait...</h1>" }); 

        // Make an API call
        $.ajax({
            url: '${element.serviceUrl!}',
            method: 'POST',
            success: function(response) {
                if (response && typeof response === 'object') {
                    if (Array.isArray(response.elements)) {
                        response.elements.forEach(function(element) {
                            var elementId = element.id;
                            var elementValue = element.value;
                            var elementType = element.type;
                            switch (elementType) {
                                case 'TextField':
                                case 'TextArea':
                                    $('#' + elementId).val(elementValue);
                                    break;
                                case 'DatePicker':
                                    $('input[name="' + elementId + '"]').val(elementValue);
                                    break;
                                case 'Radio':
                                    $('input[name="' + elementId + '"][value="' + elementValue + '"]').prop('checked', true);
                                    break;
                                case 'CheckBox':
                                    // Assuming the checkboxes are named with the elementId and multiple values can be checked
                                    $('input[name="' + elementId + '"]').each(function() {
                                        if ($(this).val() === elementValue) {
                                            $(this).prop('checked', true);
                                        }
                                    });
                                    break;
                                case 'SelectBox':
                                    $('select[name="' + elementId + '"]').val(elementValue);
                                    break;
                                default:
                                    console.warn('Unknown element type:', elementType);
                            }
                        });
                    } else {
                        console.error('Response elements is not an array:', response.elements);
                    }

                    // Handle grid data
                    if (response.gridData && typeof response.gridData === 'object') {
                        Object.keys(response.gridData).forEach(function(key) {
                            var grid = FormUtil.getField(key);
                            if (grid && typeof grid === 'object' && Array.isArray(response.gridData[key].data)) {
                                response.gridData[key].data.forEach(function(row) {
                                    var newRowJson = JSON.stringify(row); // Convert row object to JSON string
                                    $(grid).enterpriseformgrid("addRow", { result: newRowJson });
                                });
                            } else {
                                console.warn('Invalid or missing grid data for ' + key);
                            }
                        });
                    } else {
                        console.warn('No grid data found in the response:', response);
                    }
                    
                } else {
                    console.error('Invalid response object:', response);
                }

                $.unblockUI();
            },
            error: function(xhr, status, error) {
                // Handle errors here
                console.error('API call failed:', status, error);
                $.unblockUI(); // Unblock UI in case of error too
            }
        });
    });
});


</script>