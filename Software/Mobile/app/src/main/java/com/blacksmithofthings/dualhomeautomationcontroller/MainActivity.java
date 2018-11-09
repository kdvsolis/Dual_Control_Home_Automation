package com.blacksmithofthings.dualhomeautomationcontroller;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

public class MainActivity extends AppCompatActivity {

    private BluetoothAdapter btAdapter = null;
    private BluetoothSocket btSocket = null;
    private BluetoothDevice btDevice = null;
    private static final UUID MY_UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB"); //Set Bluetooth to SPP mode of connection
    private static String address = "98:D3:34:90:63:93"; //My HC-05 Address

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        try {
            btAdapter = BluetoothAdapter.getDefaultAdapter();
            checkBTState();
            btDevice = btAdapter.getRemoteDevice(address);
            btSocket = btDevice.createRfcommSocketToServiceRecord(MY_UUID);
            BluetoothAdapter.getDefaultAdapter().cancelDiscovery();
            btSocket.connect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void onSwitchClicked(View v)
    {
        try {
            switch (v.getId())
            {
                case R.id.outletButton1:
                    btSocket.getOutputStream().write("1".getBytes());
                    break;
                case R.id.outletButton2:
                    btSocket.getOutputStream().write("2".getBytes());
                    break;
                case R.id.outletButton3:
                    btSocket.getOutputStream().write("3".getBytes());
                    break;
                case R.id.outletButton4:
                    btSocket.getOutputStream().write("4".getBytes());
                    break;
                case R.id.outletButton5:
                    btSocket.getOutputStream().write("5".getBytes());
                    break;
                case R.id.outletButton6:
                    btSocket.getOutputStream().write("6".getBytes());
                    break;
                case R.id.outletButton7:
                    btSocket.getOutputStream().write("7".getBytes());
                    break;
                case R.id.outletButton8:
                    btSocket.getOutputStream().write("8".getBytes());
                    break;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void checkBTState() {
        if(btAdapter==null) {
            errorExit("Fatal Error", "Bluetooth Not supported. Aborting.");
        } else {
            if (btAdapter.isEnabled()) {
            } else {
                Intent enableBtIntent = new Intent(btAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(enableBtIntent, 1);
            }
        }
    }

    private void errorExit(String title, String message) {
        Toast msg = Toast.makeText(getBaseContext(),title + " - " + message, Toast.LENGTH_SHORT);
        msg.show();
        finish();
    }


}
