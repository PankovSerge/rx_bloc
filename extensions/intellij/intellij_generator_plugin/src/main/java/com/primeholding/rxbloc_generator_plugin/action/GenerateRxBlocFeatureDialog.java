package com.primeholding.rxbloc_generator_plugin.action;

import com.intellij.openapi.ui.DialogWrapper;

import org.jetbrains.annotations.Nullable;

import javax.swing.JCheckBox;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class GenerateRxBlocFeatureDialog extends DialogWrapper {

    private final Listener listener;
    private JTextField blocNameTextField;
    private JCheckBox withDefaultStates;
    private JPanel contentPanel;
    private JCheckBox includeExtensions;
    private JCheckBox includeNullSafety;

    public GenerateRxBlocFeatureDialog(final Listener listener) {
        super(null);
        this.listener = listener;
        init();
    }

    @Nullable
    @Override
    protected JComponent createCenterPanel() {
        return contentPanel;
    }

    @Override
    protected void doOKAction() {
        super.doOKAction();
        this.listener.onGenerateBlocClicked(
                blocNameTextField.getText(),
                withDefaultStates.isSelected(),
                includeExtensions.isSelected(),
                includeNullSafety.isSelected()
        );
    }

    @Nullable
    @Override
    public JComponent getPreferredFocusedComponent() {
        return blocNameTextField;
    }

    public interface Listener {
        void onGenerateBlocClicked(
                String blocName,
                boolean shouldUseEquatable,
                boolean includeExtensions,
                boolean includeNullSafety
        );
    }
}
