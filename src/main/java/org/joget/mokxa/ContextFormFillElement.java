package org.joget.mokxa;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import org.joget.apps.app.dao.FormDefinitionDao;
import org.joget.apps.app.model.AppDefinition;
import org.joget.apps.app.model.FormDefinition;
import org.joget.apps.app.service.AppPluginUtil;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.form.model.Element;
import org.joget.apps.form.model.Form;
import org.joget.apps.form.model.FormBuilderPaletteElement;
import org.joget.apps.form.model.FormData;
import org.joget.apps.form.service.FormUtil;
import org.joget.commons.util.LogUtil;
import org.joget.commons.util.SecurityUtil;
import org.joget.mokxa.model.*;
import org.joget.plugin.base.PluginWebSupport;
import org.joget.workflow.util.WorkflowUtil;
import org.json.JSONException;
import org.json.JSONObject;

public class ContextFormFillElement extends Element implements FormBuilderPaletteElement, PluginWebSupport {
   private static final String s_NAME = "ContextFormFillAI";
   private static final Set<String> TARGET_ELEMENT_TYPES = Set.of("org.joget.apps.form.lib.TextField", "org.joget.apps.form.lib.SelectBox", "org.joget.apps.form.lib.CheckBox", "org.joget.apps.form.lib.Radio", "org.joget.apps.form.lib.DatePicker", "org.joget.apps.form.lib.TextArea", "org.joget.apps.form.lib.Grid");
   private static final Set<String> ELEMENTS_WITH_AVAILABLE_OPTIONS = Set.of("org.joget.apps.form.lib.SelectBox", "org.joget.apps.form.lib.CheckBox", "org.joget.apps.form.lib.Radio", "org.joget.apps.form.lib.Grid");

   private static boolean isTargetElementType(String className) {
      return TARGET_ELEMENT_TYPES.contains(className);
   }

   private static boolean isElementWithAvailableOptions(String className) {
      return ELEMENTS_WITH_AVAILABLE_OPTIONS.contains(className);
   }

   public String renderTemplate(FormData formData, Map dataModel) {
      String template = "contextFormFill.ftl";
      String value = FormUtil.getElementPropertyValue(this, formData);
      if (value != null && !value.isEmpty()) {
         dataModel.put("value", value);
      }

      String html = FormUtil.generateElementHtml(this, formData, template, dataModel);
      return html;
   }

   public String getConfigString() {
      String config = "";

      try {
         JSONObject pluginProperties = FormUtil.generatePropertyJsonObject(this.getProperties());
         config = pluginProperties.toString();
      } catch (JSONException var3) {
         LogUtil.error(this.getClassName(), var3, var3.getMessage());
      }

      config = SecurityUtil.encrypt(config);
      return config;
   }

   public String getServiceUrl() {
      AppDefinition appDef = AppUtil.getCurrentAppDefinition();
      String var10000 = WorkflowUtil.getHttpServletRequest().getContextPath();
      String url = var10000 + "/web/json/app/" + appDef.getAppId() + "/" + appDef.getVersion() + "/plugin/org.joget.mokxa.ContextFormFillElement/service";
      String config = this.getConfigString();
      boolean formBuilderActive = FormUtil.isFormBuilderActive();
      if (!formBuilderActive) {
         Form form = FormUtil.findRootForm(this);
         String formDefId = (String)form.getProperty("id");
         String paramName = "";
         String nonce = SecurityUtil.generateNonce(new String[]{"ContextFormFillElement", appDef.getAppId(), appDef.getVersion().toString(), formDefId}, 1);
         this.setProperty("nonce", nonce);

         try {
            url = url + "?_nonce=" + URLEncoder.encode(nonce, "UTF-8") + "&_paramName=" + URLEncoder.encode(formDefId, "UTF-8") + "&config=" + URLEncoder.encode(config, "UTF-8");
         } catch (Exception var10) {
         }
      }

      return url;
   }

   public String getVersion() {
      return "8.0.1";
   }

   public String getName() {
      return "ContextFormFillAI";
   }

   public String getDescription() {
      return "ContextFormFillAI";
   }

   public String getLabel() {
      return "ContextFormFillAI";
   }

   public String getClassName() {
      return this.getClass().getName();
   }

   public String getPropertyOptions() {
      return AppUtil.readPluginResource(this.getClassName(), "/properties/contextFormFill.json", null, true, "messages/ContextFormFill");
   }

   public String getFormBuilderCategory() {
      return "Mokxa";
   }

   public int getFormBuilderPosition() {
      return 900;
   }

   public String getFormBuilderIcon() {
      return "<i class=\"fas fa-robot\"></i>";
   }

   public String getFormBuilderTemplate() {
      return "<label class='label'>ContextFormFillAI</label><input type='text' />";
   }

   public void jogetFormToSimpleForm(JsonObject formJsonElement, List<FormElement> formElementsProcessed) {
      if (formJsonElement.has("elements") && formJsonElement.get("elements").isJsonArray()) {
         JsonArray elementsArray = formJsonElement.getAsJsonArray("elements");
         Iterator var4 = elementsArray.iterator();

         while(var4.hasNext()) {
            JsonElement subElement = (JsonElement)var4.next();
            if (subElement.isJsonObject()) {
               this.jogetFormToSimpleForm(subElement.getAsJsonObject(), formElementsProcessed);
            }
         }
      }

      if (formJsonElement.has("className")) {
         String className = formJsonElement.get("className").getAsString();

         if (isTargetElementType(className) && formJsonElement.has("properties")) {
            JsonObject properties = formJsonElement.getAsJsonObject("properties");

            String formElementId = properties.has("id") ? properties.get("id").getAsString() : "";
            String formElementName = properties.has("label") ? properties.get("label").getAsString() : "";
            String formElementClass = getTypeFromClassName(className);
            boolean readonly = properties.has("readonly") && properties.get("readonly").getAsString().equals("true");

            List<String> availableOptions = new ArrayList<>();

            if(!readonly){
               if (isElementWithAvailableOptions(className)) {
                  JsonArray optionsArray = properties.getAsJsonArray("options");

                  if (optionsArray != null && optionsArray.size() > 0) {
                     for (JsonElement optionElement : optionsArray) {
                        JsonObject option = optionElement.getAsJsonObject();
                        availableOptions.add(option.get("value").getAsString());
                     }
                  } else {
                     // Case 2: Dynamic SQL options (JdbcOptionsBinder)
                     if (properties.has("optionsBinder")) {
                        JsonObject binder = properties.getAsJsonObject("optionsBinder");

                        String binderClass = binder.get("className").getAsString();

                        if ("org.joget.plugin.enterprise.JdbcOptionsBinder".equals(binderClass)) {
                           JsonObject binderProps = binder.getAsJsonObject("properties");
                           if (binderProps != null && binderProps.has("sql")) {
                              String sql = binderProps.get("sql").getAsString();
                              try {
                                 DataSource ds = (DataSource) AppUtil.getApplicationContext().getBean("setupDataSource");
                                 Connection con = ds.getConnection();
                                 PreparedStatement stmt = con.prepareStatement(sql);
                                 ResultSet rs = stmt.executeQuery();

                                 while (rs.next()) {
                                    String value = rs.getString(1);  // c_lookup_value
                                    availableOptions.add(value);
                                 }

                                 rs.close();
                                 stmt.close();
                                 con.close();
                              } catch (Exception e) {
                                 e.printStackTrace();
                              }
                           }
                        }
                     }
                  }
               }

               formElementsProcessed.add(
                       new FormElement(formElementId, formElementName, "", formElementClass, availableOptions)
               );
            }

         }
      }

   }

   public String returnGptPrompt(String formElements) {
      LocalDate currentDate = LocalDate.now();
      LogUtil.info(getClass().getName(),formElements);
      return "Based on the provided content, please help and complete this JSON provided in the same format.\nReturn only a JSON with unescaped characters so that it can be easily parsed.\nToday's date is " + currentDate + "\n\nThe Form JSON you have to fill is:\n" + formElements + "\n\nIMPORTANT: For any DatePicker fields, ensure dates are formatted as MM/dd/yyyy (e.g., 04/22/2025).\n\nFor CheckBox elements, the value should be a list which contains all the selected values\n\nFor Grid elements, the value should be a valid sub JSON list which contains all the availableOptions as `column` keys and the value to be filled in the `value` key. The Grid elements are a type of table which is why the schema should be consistent to inlude all availableOptions in the `column`.Example: {\n    \"id\": \"sample_id\",\n    \"label\": \"Sample Label\",\n    \"type\": \"Grid\",\n    \"value\": [\n\t\t# Row 1\n        {\n            \"column1\": \"sample value\",\n            \"column2\": \"sample value\"\n        },\n\t\t# Row 2\n        {\n            \"column1\": \"sample value\",\n            \"column2\": \"sample value\"\n        }\n    ],\n    \"availableOptions\": [\n        \"column1\",\n        \"column2\"\n    ]\n}";
   }

   public void webService(HttpServletRequest request, HttpServletResponse response) throws IOException {
      if ("POST".equalsIgnoreCase(request.getMethod())) {
         AppDefinition appDef = AppUtil.getCurrentAppDefinition();
         String nonce = request.getParameter("_nonce");
         String paramName = request.getParameter("_paramName");
         if (SecurityUtil.verifyNonce(nonce, new String[]{"ContextFormFillElement", appDef.getAppId(), appDef.getVersion().toString(), paramName})) {
            try {
               String suffix = AppPluginUtil.getMessage("org.joget.ai.form_fill_element.contextAiformfill.proxyDomain.standardEndpoint", this.getClassName(), "messages/ContextFormFill");
               String config = SecurityUtil.decrypt(request.getParameter("config"));
               JSONObject configJson = new JSONObject(config);
               String apiKey = configJson.getString("apiKey");
               String model = configJson.getString("model");
               String domain = configJson.getString("proxyDomain");
               String imageBase64Json = request.getParameter("imageBase64List");
               if (model.toLowerCase().contains("gemini")) {
                  if (domain == null || domain.trim().isEmpty()) {
                     domain = AppPluginUtil.getMessage("org.joget.ai.form_fill_element.contextAiformfill.proxyDomain.defaultValueGemini", this.getClassName(), "messages/ContextFormFill");
                  }
               } else if (domain == null || domain.trim().isEmpty()) {
                  domain = AppPluginUtil.getMessage("org.joget.ai.form_fill_element.contextAiformfill.proxyDomain.defaultValueOpenAI", this.getClassName(), "messages/ContextFormFill");
               }

               String endPoint;
               if (domain.endsWith("/chat/completions")) {
                  endPoint = domain;
               } else if (domain.endsWith("/")) {
                  endPoint = domain + suffix;
               } else {
                  endPoint = domain + "/" + suffix;
               }

               if (imageBase64Json == null || imageBase64Json.isEmpty()) {
                  throw new JSONException("imageBase64List parameter is missing or empty");
               }

               List<String> base64Images = (new Gson()).fromJson(imageBase64Json, (new TypeToken<List<String>>() {
               }).getType());
               FormDefinitionDao formDefinitionDao = (FormDefinitionDao)FormUtil.getApplicationContext().getBean("formDefinitionDao");
               FormDefinition formDef = formDefinitionDao.loadById(paramName, appDef);
               String formJson = formDef.getJson();
               LogUtil.info(getClass().getName(),"Form values: "+formJson);
               JsonObject formJsonObject = JsonParser.parseString(formJson).getAsJsonObject();
               List<FormElement> formElementsProcessed = new ArrayList();
               this.jogetFormToSimpleForm(formJsonObject, formElementsProcessed);
               String llmPrompt = this.returnGptPrompt(formElementsProcessed.toString());
               Result gptResponse = this.callChatGPTApi(endPoint, apiKey, model, llmPrompt, base64Images);
               Gson jsonConverter = new Gson();
               String output = jsonConverter.toJson(gptResponse);
               response.setStatus(gptResponse.getCode());
               response.setContentType("application/json");
               response.setCharacterEncoding("UTF-8");
               PrintWriter out = response.getWriter();
               out.print(output);
               out.flush();
            } catch (JSONException var25) {
               this.sendErrorResponse(response, 400, "Invalid JSON format", var25);
            } catch (Exception var26) {
               this.sendErrorResponse(response, 500, "Unexpected error", var26);
            }
         }
      }

   }

   private void sendErrorResponse(HttpServletResponse response, int statusCode, String errorType, Throwable ex) throws IOException {
      LogUtil.error(this.getClassName(), ex, "Error in ContextFormFillElement web service: " + ex.getMessage());
      response.setStatus(statusCode);
      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      PrintWriter out = response.getWriter();
      out.print("{\"" + errorType + "\": \"" + ex.getMessage() + "\"}");
      out.flush();
   }

   private Result callChatGPTApi(String domain, String apiKey, String model, String prompt, List<String> base64Images) {
      HttpClient httpClient = HttpClientBuilder.create().build();
      HttpPost postRequest = new HttpPost(domain);
      postRequest.addHeader("Content-Type", "application/json");
      postRequest.addHeader("Authorization", "Bearer " + apiKey);
      Chat chat = getChat(model, prompt, base64Images);
      Gson gson = new Gson();
      String requestBody = gson.toJson(chat);

      try {
         StringEntity params = new StringEntity(requestBody);
         postRequest.setEntity(params);
         HttpResponse response = httpClient.execute(postRequest);
         String responseBody = EntityUtils.toString(response.getEntity());
         Result result;
         String gptOutput;
         if (response.getStatusLine().getStatusCode() == 200) {
            ChatGptResponse cgr = gson.fromJson(responseBody, ChatGptResponse.class);
            result = new Result();
            result.setCode(response.getStatusLine().getStatusCode());
            gptOutput = cgr.getChoices().get(0).getMessage().getContent();
            gptOutput = gptOutput.replace("```json", "");
            gptOutput = gptOutput.replace("```", "");
            Gson gsonBuilder = (new GsonBuilder()).setPrettyPrinting().create();
            Object jsonObject = gsonBuilder.fromJson(gptOutput, Object.class);
            String formattedJson = gsonBuilder.toJson(jsonObject);
            result.setContent(formattedJson);
            return result;
         }

         ChatGptErrorResponse cger = gson.fromJson(responseBody, ChatGptErrorResponse.class);
         result = new Result();
         result.setCode(response.getStatusLine().getStatusCode());
         gptOutput = cger.getError().getMessage();
         result.setContent(gptOutput);
         return result;
      } catch (IOException var20) {
         LogUtil.error(this.getClassName(), var20, "Error calling ChatGPT API");
      } catch (JsonSyntaxException var21) {
         LogUtil.error(this.getClassName(), var21, "Error parsing ChatGPT response");
      }

      return null;
   }

   private static Chat getChat(String model, String prompt, List<String> base64Images) {
      List<ChatGptMessage> messages = new ArrayList();
      List<ChatGptMessage.Content> contentList = new ArrayList();
      ChatGptMessage.Content textContent = new ChatGptMessage.Content();
      textContent.setType("text");
      textContent.setText(prompt);
      contentList.add(textContent);
      Iterator var6 = base64Images.iterator();

      while(var6.hasNext()) {
         String base64Image = (String)var6.next();
         ChatGptMessage.Content imageContent = new ChatGptMessage.Content();
         imageContent.setType("image_url");
         ChatGptMessage.ImageUrl imageUrl = new ChatGptMessage.ImageUrl();
         imageUrl.setUrl(base64Image);
         imageContent.setImageUrl(imageUrl);
         contentList.add(imageContent);
      }

      ChatGptMessage userMessage = new ChatGptMessage();
      userMessage.setRole("user");
      userMessage.setContent(contentList);
      messages.add(userMessage);
      Chat chat = new Chat();
      chat.setModel(model);
      chat.setMessages(messages);
      chat.setMaxTokens(4096);

      return chat;
   }

   private static String getTypeFromClassName(String className) {
      return className.substring(className.lastIndexOf(".") + 1);
   }
}
