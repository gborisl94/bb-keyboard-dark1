package com.bb.keyboard

import android.inputmethodservice.InputMethodService
import android.view.MotionEvent
import android.view.View
import android.widget.Button
import kotlin.math.abs

class BBInputMethodService : InputMethodService() {

    private var lastX = 0f
    private var isSliding = false

    override fun onCreateInputView(): View {
        val view = layoutInflater.inflate(com.bb.keyboard_dark.R.layout.keyboard_view, null)
        
        // Lettres
        val keys = mapOf(
            R.id.key_q to "q", R.id.key_w to "w", R.id.key_e to "e",
            R.id.key_r to "r", R.id.key_t to "t", R.id.key_y to "y",
            R.id.key_a to "a", R.id.key_s to "s", R.id.key_d to "d", R.id.key_f to "f"
        )
        keys.forEach { (id, letter) ->
            view.findViewById<Button>(id)?.setOnClickListener {
                currentInputConnection?.commitText(letter, 1)
            }
        }

        // Delete
        view.findViewById<Button>(R.id.key_del)?.setOnClickListener {
            currentInputConnection?.deleteSurroundingText(1, 0)
        }

        // Enter
        view.findViewById<Button>(R.id.key_enter)?.setOnClickListener {
            currentInputConnection?.commitText("\n", 1)
        }

        // SPACE AVEC SLIDE CURSEUR
        val space = view.findViewById<Button>(R.id.key_space)
        space?.setOnTouchListener { _, event ->
            val ic = currentInputConnection
            when (event.action) {
                MotionEvent.ACTION_DOWN -> {
                    lastX = event.x
                    isSliding = false
                    true
                }
                MotionEvent.ACTION_MOVE -> {
                    val dx = event.x - lastX
                    if (abs(dx) > 25) { // seuil de glissement
                        isSliding = true
                        if (dx > 0) {
                            // droite
                            ic?.sendKeyEvent(android.view.KeyEvent(android.view.KeyEvent.ACTION_DOWN, android.view.KeyEvent.KEYCODE_DPAD_RIGHT))
                            ic?.sendKeyEvent(android.view.KeyEvent(android.view.KeyEvent.ACTION_UP, android.view.KeyEvent.KEYCODE_DPAD_RIGHT))
                        } else {
                            // gauche
                            ic?.sendKeyEvent(android.view.KeyEvent(android.view.KeyEvent.ACTION_DOWN, android.view.KeyEvent.KEYCODE_DPAD_LEFT))
                            ic?.sendKeyEvent(android.view.KeyEvent(android.view.KeyEvent.ACTION_UP, android.view.KeyEvent.KEYCODE_DPAD_LEFT))
                        }
                        lastX = event.x
                    }
                    true
                }
                MotionEvent.ACTION_UP -> {
                    if (!isSliding) {
                        ic?.commitText(" ", 1)
                    }
                    isSliding = false
                    true
                }
                else -> false
            }
        }
        return view
    }
}