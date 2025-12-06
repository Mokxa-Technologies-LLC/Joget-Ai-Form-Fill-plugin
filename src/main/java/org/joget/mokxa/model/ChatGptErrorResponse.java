package org.joget.mokxa.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class ChatGptErrorResponse {
   private Error error;
   private Map<String, Object> additionalProperties = new LinkedHashMap();

   public Error getError() {
      return this.error;
   }

   public void setError(Error error) {
      this.error = error;
   }

   public Map<String, Object> getAdditionalProperties() {
      return this.additionalProperties;
   }

   public void setAdditionalProperty(String name, Object value) {
      this.additionalProperties.put(name, value);
   }
}
