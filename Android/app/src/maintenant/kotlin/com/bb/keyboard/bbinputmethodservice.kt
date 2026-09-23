package com.bb.keyboard

import android.inputmethodservice.InputMethodService
import android.view.View
import android.view.inputmethod.EditorInfo

class BBInputMethodService : InputMethodService() {
    override fun onCreateInputView(): View {
        val view = layoutInflater.inflate(R.layout.keyboard_view, null)
        // Ici on branche ton clavier dark custom avec le slide sur espace
        return view
    }
}