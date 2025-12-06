package org.joget.mokxa;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Dictionary;
import java.util.Iterator;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

public class Activator implements BundleActivator {
   public static final String s_VERSION = "8.0.1";
   public static final String s_AFF_MESSAGE_PATH = "messages/AutoFormFill";
   public static final String s_CFF_MESSAGE_PATH = "messages/ContextFormFill";
   public static final String s_BUILDER_CATEGORY = "Mokxa";
   public static final int s_BUILDER_POSITION = 900;
   protected Collection<ServiceRegistration> registrationList;

   public void start(BundleContext context) {
      this.registrationList = new ArrayList();
      this.registrationList.add(context.registerService(ContextFormFillElement.class.getName(), new ContextFormFillElement(), (Dictionary)null));
   }

   public void stop(BundleContext context) {
      Iterator var2 = this.registrationList.iterator();

      while(var2.hasNext()) {
         ServiceRegistration registration = (ServiceRegistration)var2.next();
         registration.unregister();
      }

   }
}
