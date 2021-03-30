classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        SpeakButton                   matlab.ui.control.Button
        TextToPhonemesEditFieldLabel  matlab.ui.control.Label
        TextToPhonemesEditField       matlab.ui.control.EditField
        PhonemesLabel                 matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: SpeakButton
        function SpeakButtonPushed(app, event)
            text = convertCharsToStrings(app.TextToPhonemesEditField.Value);
            sound(sentenceToSound(text));
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.149 0.149 0.149];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create SpeakButton
            app.SpeakButton = uibutton(app.UIFigure, 'push');
            app.SpeakButton.ButtonPushedFcn = createCallbackFcn(app, @SpeakButtonPushed, true);
            app.SpeakButton.BackgroundColor = [0.0118 0.3098 0.6196];
            app.SpeakButton.FontName = 'Berlin Sans FB Demi';
            app.SpeakButton.FontSize = 25;
            app.SpeakButton.FontWeight = 'bold';
            app.SpeakButton.FontColor = [1 1 1];
            app.SpeakButton.Position = [151 211 330 90];
            app.SpeakButton.Text = 'Speak';

            % Create TextToPhonemesEditFieldLabel
            app.TextToPhonemesEditFieldLabel = uilabel(app.UIFigure);
            app.TextToPhonemesEditFieldLabel.HorizontalAlignment = 'center';
            app.TextToPhonemesEditFieldLabel.VerticalAlignment = 'top';
            app.TextToPhonemesEditFieldLabel.FontName = 'Bookman';
            app.TextToPhonemesEditFieldLabel.FontSize = 30;
            app.TextToPhonemesEditFieldLabel.FontWeight = 'bold';
            app.TextToPhonemesEditFieldLabel.FontColor = [1 1 1];
            app.TextToPhonemesEditFieldLabel.Position = [180 415 271 36];
            app.TextToPhonemesEditFieldLabel.Text = 'Text To Phonemes';

            % Create TextToPhonemesEditField
            app.TextToPhonemesEditField = uieditfield(app.UIFigure, 'text');
            app.TextToPhonemesEditField.HorizontalAlignment = 'center';
            app.TextToPhonemesEditField.FontName = 'AvantGarde';
            app.TextToPhonemesEditField.FontSize = 20;
            app.TextToPhonemesEditField.FontColor = [1 1 1];
            app.TextToPhonemesEditField.BackgroundColor = [0.7961 0.8471 0.9608];
            app.TextToPhonemesEditField.Position = [151 314 330 84];
            app.TextToPhonemesEditField.Value = 'Enter Here';

            % Create PhonemesLabel
            app.PhonemesLabel = uilabel(app.UIFigure);
            app.PhonemesLabel.HorizontalAlignment = 'center';
            app.PhonemesLabel.WordWrap = 'on';
            app.PhonemesLabel.FontSize = 18;
            app.PhonemesLabel.FontColor = [1 1 1];
            app.PhonemesLabel.Position = [1 1 640 204];
            app.PhonemesLabel.Text = 'Phonemes';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end