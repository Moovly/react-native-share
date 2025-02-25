package cl.json.social;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.os.Environment;
import android.net.Uri;
import android.util.Log;

import java.io.File;

import cl.json.ShareFile;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReadableMap;

/**
 * Created by Kaio Duarte on 23-12-20.
 */
public class FacebookReelsShare extends SingleShareIntent {

    private static final String PACKAGE = "com.facebook.katana";
    private static final String PLAY_STORE_LINK = "market://details?id=com.facebook.katana";

    public FacebookReelsShare(ReactApplicationContext reactContext) {
        super(reactContext);
        this.setIntent(new Intent("com.facebook.reels.SHARE_TO_REEL"));
    }

    @Override
    public void open(ReadableMap options) throws ActivityNotFoundException, IllegalArgumentException {
        super.open(options);
        this.shareStory(options);
        // extra params here
        this.openIntentChooser(options);
    }

    @Override
    protected String getPackage() {
        return PACKAGE;
    }

    @Override
    protected String getDefaultWebLink() {
        return null;
    }

    @Override
    protected String getPlayStoreLink() {
        return PLAY_STORE_LINK;
    }

    private void shareStory(ReadableMap options) {
        if (!this.hasValidKey("appId", options)) {
            throw new IllegalArgumentException("appId was not provided.");
        }

        Activity activity = this.reactContext.getCurrentActivity();

        if (activity == null) {
            TargetChosenReceiver.sendCallback(false, "Something went wrong");
            return;
        }

        this.intent.putExtra("com.facebook.platform.extra.APPLICATION_ID", options.getString("appId"));
       

        Boolean useInternalStorage = false;
        if (this.hasValidKey("useInternalStorage", options)) {
            useInternalStorage = options.getBoolean("useInternalStorage");
        }

        String backgroundFileName = options.getString("backgroundVideo");
        ShareFile backgroundAsset = new ShareFile(backgroundFileName, "video/mp4", "background", useInternalStorage, this.reactContext);


        this.intent.setDataAndType(backgroundAsset.getURI(), backgroundAsset.getType());
        this.intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);


    }
}
