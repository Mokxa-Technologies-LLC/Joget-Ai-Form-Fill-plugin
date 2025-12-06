package org.joget.mokxa.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Usage {
   private Integer promptTokens;
   private Integer completionTokens;
   private Integer totalTokens;
   private Map<String, Object> additionalProperties = new LinkedHashMap();

   public Integer getPromptTokens() {
      return this.promptTokens;
   }

   public void setPromptTokens(Integer promptTokens) {
      this.promptTokens = promptTokens;
   }

   public Integer getCompletionTokens() {
      return this.completionTokens;
   }

   public void setCompletionTokens(Integer completionTokens) {
      this.completionTokens = completionTokens;
   }

   public Integer getTotalTokens() {
      return this.totalTokens;
   }

   public void setTotalTokens(Integer totalTokens) {
      this.totalTokens = totalTokens;
   }

   public Map<String, Object> getAdditionalProperties() {
      return this.additionalProperties;
   }

   public void setAdditionalProperty(String name, Object value) {
      this.additionalProperties.put(name, value);
   }
}
