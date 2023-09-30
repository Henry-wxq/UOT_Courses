package com.henryw.recipeorganizer;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class CallDemo1 {
    public static void main(String[] args) {
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url("https://api.edamam.com/search?q=pasta&app_id=YOUR_APP_ID&app_key=YOUR_APP_KEY")
                .get()
                .build();

        try {
            Response response = client.newCall(request).execute();
            System.out.println("API Response: " + response.body().string());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
