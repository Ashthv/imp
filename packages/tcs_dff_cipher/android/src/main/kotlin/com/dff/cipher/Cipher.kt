package com.dff.cipher

import android.util.Base64
import java.io.UnsupportedEncodingException
import java.security.InvalidKeyException
import java.security.Key
import java.security.KeyFactory
import java.security.NoSuchAlgorithmException
import java.security.spec.InvalidKeySpecException
import java.security.spec.PKCS8EncodedKeySpec
import java.security.spec.X509EncodedKeySpec
import javax.crypto.BadPaddingException
import javax.crypto.Cipher
import javax.crypto.IllegalBlockSizeException
import javax.crypto.KeyGenerator
import javax.crypto.NoSuchPaddingException
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec
import android.util.Log



object Cipher {
    @Throws(NoSuchAlgorithmException::class)
    fun generateAESKey(keySize: Int): String {
        val keyGenerator = KeyGenerator.getInstance("AES")
        keyGenerator.init(keySize)
        return Base64.encodeToString(keyGenerator.generateKey().encoded, Base64.NO_WRAP)
    }

    @Throws(
        NoSuchPaddingException::class,
        NoSuchAlgorithmException::class,
        InvalidKeyException::class,
        IllegalBlockSizeException::class,
        BadPaddingException::class,
        UnsupportedEncodingException::class,
        InvalidKeySpecException::class
    )
    fun encrypt(plaintext: String, key: String?, algorithmName: String,transformation:String, initializationVector:String?): String {
        val cipher = Cipher.getInstance(transformation)
        val encodedKey = Base64.decode(key,  Base64.NO_WRAP)
        if (algorithmName == "RSA") {
            val keyFactory = KeyFactory.getInstance("RSA")
            val x509KeySpec = X509EncodedKeySpec(encodedKey)
            val x509key: Key = keyFactory.generatePublic(x509KeySpec)
            cipher.init(Cipher.ENCRYPT_MODE, x509key)
        } else {
            cipher.init(
                Cipher.ENCRYPT_MODE,
                SecretKeySpec(encodedKey, algorithmName),IvParameterSpec(initializationVector?.toByteArray())
            )
        }
        return String(
            Base64.encode(
                cipher.doFinal(plaintext.toByteArray()),
                Base64.NO_WRAP
            )
        )
    }

    @Throws(
        NoSuchPaddingException::class,
        NoSuchAlgorithmException::class,
        InvalidKeyException::class,
        IllegalBlockSizeException::class,
        BadPaddingException::class,
        UnsupportedEncodingException::class
    )
    fun decrypt(cipherText: String, key: String?, algorithmName: String?,transformation:String, initializationVector:String?): String {
        val cipher = Cipher.getInstance(transformation)
        val encodedKey = Base64.decode(key,  Base64.NO_WRAP)
        if(algorithmName=="RSA"){
            val keyFactory = KeyFactory.getInstance(algorithmName)
            val pkcS8EncodedKeySpec = PKCS8EncodedKeySpec(encodedKey)
            val pkcS8Key:Key=keyFactory.generatePrivate(pkcS8EncodedKeySpec);
            cipher.init(Cipher.DECRYPT_MODE,pkcS8Key)
        }else{
            cipher.init(
                Cipher.DECRYPT_MODE,
                SecretKeySpec(encodedKey, algorithmName),
                IvParameterSpec(initializationVector?.toByteArray())
            )
        }
        return String(
            cipher.doFinal(
                Base64.decode(
                    cipherText.toByteArray(),
                    Base64.NO_WRAP
                )
            )
        )
    }
}