package org.joget.mokxa.model;

import java.util.List;
import org.json.JSONObject;

public class FormElement {
   private String id;
   private String label;
   private String value;
   private String type;
   private List<String> availableOptions;

   public FormElement(String id, String label, String value, String type, List<String> availableOptions) {
      this.id = id;
      this.label = label;
      this.value = value;
      this.type = type;
      this.availableOptions = availableOptions;
   }

   public String getId() {
      return this.id;
   }

   public String getLabel() {
      return this.label;
   }

   public void setId(String id) {
      this.id = id;
   }

   public void setLabel(String label) {
      this.label = label;
   }

   public String getValue() {
      return this.value;
   }

   public void setValue(String value) {
      this.value = value;
   }

   public String getType() {
      return this.type;
   }

   public void setType(String type) {
      this.type = type;
   }

   public String getAvailableOptions() {
      return this.availableOptions.toString();
   }

   public void setAvailableOptions(List<String> availableOptions) {
      this.availableOptions = availableOptions;
   }

   public String toString() {
      JSONObject formElement = new JSONObject();
      formElement.put("id", this.id);
      formElement.put("label", this.label);
      formElement.put("value", this.value);
      formElement.put("type", this.type);
      if (this.availableOptions != null) {
         formElement.put("availableOptions", this.availableOptions);
      }

      return formElement.toString();
   }
}
