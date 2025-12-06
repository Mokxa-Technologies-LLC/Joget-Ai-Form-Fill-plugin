package org.joget.mokxa.model;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ChatGptResponse {
   private String id;
   private String object;
   private Integer created;
   private String model;
   private Usage usage;
   private List<Choice> choices;
   private Map<String, Object> additionalProperties = new LinkedHashMap();

   public String getId() {
      return this.id;
   }

   public void setId(String id) {
      this.id = id;
   }

   public String getObject() {
      return this.object;
   }

   public void setObject(String object) {
      this.object = object;
   }

   public Integer getCreated() {
      return this.created;
   }

   public void setCreated(Integer created) {
      this.created = created;
   }

   public String getModel() {
      return this.model;
   }

   public void setModel(String model) {
      this.model = model;
   }

   public Usage getUsage() {
      return this.usage;
   }

   public void setUsage(Usage usage) {
      this.usage = usage;
   }

   public List<Choice> getChoices() {
      return this.choices;
   }

   public void setChoices(List<Choice> choices) {
      this.choices = choices;
   }

   public Map<String, Object> getAdditionalProperties() {
      return this.additionalProperties;
   }

   public void setAdditionalProperty(String name, Object value) {
      this.additionalProperties.put(name, value);
   }
}
