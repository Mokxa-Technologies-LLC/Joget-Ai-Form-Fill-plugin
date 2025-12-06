package org.joget.mokxa.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Choice {
   private Message message;
   private String finishReason;
   private Integer index;
   private Map<String, Object> additionalProperties = new LinkedHashMap();

   public Message getMessage() {
      return this.message;
   }

   public void setMessage(Message message) {
      this.message = message;
   }

   public String getFinishReason() {
      return this.finishReason;
   }

   public void setFinishReason(String finishReason) {
      this.finishReason = finishReason;
   }

   public Integer getIndex() {
      return this.index;
   }

   public void setIndex(Integer index) {
      this.index = index;
   }

   public Map<String, Object> getAdditionalProperties() {
      return this.additionalProperties;
   }

   public void setAdditionalProperty(String name, Object value) {
      this.additionalProperties.put(name, value);
   }
}
