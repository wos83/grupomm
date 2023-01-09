//*******************************************************
//
//           CodeGear Delphi Runtime Library
// Copyright(c) 2014-2022 Embarcadero Technologies, Inc.
//              All rights reserved
//
//*******************************************************

package com.embarcadero.services;

import android.app.Service;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.IBinder;
import android.os.Binder;
import android.os.Message;
import android.os.Messenger;
import android.os.Handler;

import com.embarcadero.rtl.ProxyService;

public class <%ServiceName%> extends Service {
    private final String baseLibraryName = "<%ServiceName%>"; 
    private String libraryName;

    /**
     * Handler of incoming messages from clients.
     */
    public class IncomingHandler extends Handler {
        private Object mParent;
        
        public IncomingHandler(Object parent) {
           mParent = parent;
        }
              
        @Override
        public void handleMessage(Message msg) {
            if (!ProxyService.onHandleMessage(mParent, libraryName, msg))
                super.handleMessage(msg);
        }
    }

    /**
     * Target we publish for clients to send messages to IncomingHandler.
     */
    final Messenger mMessenger = new Messenger(new IncomingHandler(this));
    public final IBinder mBinder = mMessenger.getBinder();

    @Override
    public void onCreate() {
        libraryName = "lib" + baseLibraryName + ".so";
        super.onCreate();
        ProxyService.onCreate(this, libraryName);        
    }

    @Override
    public void onDestroy() {
        ProxyService.onDestroy(this, libraryName);
        super.onDestroy();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        return ProxyService.onStartCommand(this, libraryName, intent, flags, startId);
    }

    @Override
    public IBinder onBind(Intent intent) {
        return ProxyService.onBind(this, libraryName, intent);
    }

    @Override
    public void onRebind(Intent intent) {
        ProxyService.onRebind(this, libraryName, intent);
    }

    @Override
    public boolean onUnbind(Intent intent) {
        return ProxyService.onUnbind(this, libraryName, intent);
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        ProxyService.onConfigurationChanged(this, libraryName, newConfig);
    }

    @Override
    public void onLowMemory() {
        ProxyService.onLowMemory(this, libraryName);
    }

    @Override
    public void onTrimMemory(int level) {
        ProxyService.onTrimMemory(this, libraryName, level);
    }
}
