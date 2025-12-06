package org.joget.mokxa.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Message {
   private String role;
   private String content;
   private Map<String, Object> additionalProperties = new LinkedHashMap();

   public String getRole() {
      return this.role;
   }

   public void setRole(String role) {
      this.role = role;
   }

   public String getContent() {
      return this.content;
   }

   public void setContent(String content) {
      this.content = content;
   }

   public Map<String, Object> getAdditionalProperties() {
      return this.additionalProperties;
   }

   public void setAdditionalProperty(String name, Object value) {
      this.additionalProperties.put(name, value);
   }
}
