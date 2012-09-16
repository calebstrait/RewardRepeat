% Copyright (c) 2012 Aaron Roth
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
%

function reward_repeat(monkeysInitial)
    % ---------------------------------------------- %
    % -------------- Global variables -------------- %
    % ---------------------------------------------- %
    
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@                                @@@@@@@ %
    % @@@@@@@  FREQUENTLY CHANGED VARIABLES  @@@@@@@ %
    % @@@@@@@                                @@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    
      experimentType = 'training1';         % Values: 'training1' (all borders), 
                                            %         'training2' (no borders 
                                            %         during choice phase), or
                                            %         'regular' (no borders).
      
      images         = [{'stone'}];         % Values: Any cell array of string
                                            %         image names.
      
      rewardPause    = 0.1;                 % Values: Any integer. Pause between
                                            %         rewards with multi rewards.                             
      
      rewardVSmall   = [0.06]; %#ok<*NBRAK> % Values: Any array of number reward
                                            %         durations.
      rewardSmall    = [0.08];              % Values: Any array of number reward
                                            %         durations.
      rewardMedium   = [0.1];               % Values: Any array of number reward
                                            %         durations.
      rewardLarge    = [0.12];              % Values: Any array of number reward
                                            %         durations.
      rewardVLarge   = [0.14];              % Values: Any array of number reward
                                            %         durations.
      
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    
    % Colors.
    colorBackground  = [0 0 0];
    colorBlue        = [0 0 255];
    colorCyan        = [0 255 255];
    colorGray        = [128 128 128];
    colorGreen       = [0 255 0];
    colorOrange      = [255 127 0];
    colorYellow      = [255 255 0];
    colorWhite       = [255 255 255];
    
    % Coordinates.
    centerX          = 512;                  % X pixel coordinate for the screen center.
    centerY          = 384;                  % Y pixel coordinate for the screen center.
    endsBoundAdj     = 384;                  % Coordinate adjustment.
    fixAdjust        = 172;                  % Target fixation adjustments.
    grayBarHeight    = 400;                  % Height of the neutral gray bar.
    hfWidth          = 88;                   % Half the width of the fixation boxes.
    imageWidth       = 128;                  % The width of the presented images.
    imageHeight      = 128;                  % The height of the presented images.
    sideBoundAdj     = 211;                  % Coordinate adjustment.
    
    % Values to calculate fixation boxes.
    fixBoundXMax     = centerX + hfWidth;
    fixBoundXMin     = centerX - hfWidth;
    fixBoundYMax     = centerY + hfWidth;
    fixBoundYMin     = centerY - hfWidth;
    
    % Fixation bondaries for the left stimulus.
    leftBoundXMax    = 2 * centerX - 4 * hfWidth - imageWidth - fixAdjust;
    leftBoundXMin    = centerX - imageWidth - sideBoundAdj - fixAdjust;
    leftBoundYMax    = centerY + endsBoundAdj;
    leftBoundYMin    = centerY - endsBoundAdj;
    
    % Fixation boundaries for the right stimulus.
    rightBoundXMax   = centerX + imageWidth + sideBoundAdj + fixAdjust;
    rightBoundXMin   = 4 * hfWidth + imageWidth + fixAdjust;
    rightBoundYMax   = centerY + endsBoundAdj;
    rightBoundYMin   = centerY - endsBoundAdj;
    
    % Coordinates for drawing the left stimulus image. 
    leftStimXMax     = leftBoundXMax / 2 + imageWidth / 2;
    leftStimXMin     = leftBoundXMax / 2 - imageWidth / 2;
    leftStimYMax     = centerY + imageHeight / 2;
    leftStimYMin     = centerY - imageHeight / 2;
    
    % Coordinates for drawing the right stimulus image.
    rightStimXMax    = rightBoundXMax - (rightBoundXMax - rightBoundXMin) / 2 + imageWidth / 2;
    rightStimXMin    = rightBoundXMax - (rightBoundXMax - rightBoundXMin) / 2 - imageWidth / 2;
    rightStimYMax    = centerY + imageHeight / 2;
    rightStimYMin    = centerY - imageHeight / 2;
    
    % Coordinates for drawing the left grey bar.
    leftGreyXMax     = leftBoundXMax / 2 + imageWidth / 2;
    leftGreyXMin     = leftBoundXMax / 2 - imageWidth / 2;
    leftGreyYMax     = centerY + grayBarHeight / 2;
    leftGreyYMin     = centerY - grayBarHeight / 2;
    
    % Coordinates for drawing the right grey bar.
    rightGreyXMax    = rightBoundXMax - (rightBoundXMax - rightBoundXMin) / 2 + imageWidth / 2;
    rightGreyXMin    = rightBoundXMax - (rightBoundXMax - rightBoundXMin) / 2 - imageWidth / 2;
    rightGreyYMax    = centerY + grayBarHeight / 2;
    rightGreyYMin    = centerY - grayBarHeight / 2;
    
    % Coordinates for drawing the center probe.
    centerProbeXMax  = centerX + imageWidth / 2;
    centerProbeXMin  = centerX - imageWidth / 2;
    centerProbeYMax  = centerY + imageWidth / 2;
    centerProbeYMin  = centerY - imageWidth / 2;
    
    % References.
    monkeyScreen     = 1;                    % Number of the screen the monkey sees.
    trackedEye       = 2;                    % Values: 1 (left eye), 2 (right eye).
    
    % Saving.
    choiceMade       = '';                   % Which side was chosen.
    data             = struct([]);           % Workspace variable where trial data is saved.
    numCorrTimes     = 0;                    % Times "correct" probe option chosen.
    percentCorrect   = 0;                    % Percent "corect" probe chosen.
    rewardRepeatData = '/Data/RewardRepeat'; % Directory where .mat files are saved.
    saveCommand      = NaN;                  % Command string that will save .mat files.
    varName          = 'data';               % Name of the variable to save in the workspace.
    
    % Stimuli.
    bordThick        = 20;                   % Thickness for all borders.
    dotRadius        = 10;                   % Radius of the fixation dot.
    feedThick        = 10;                   % Thickness of the feedback borders.
    fixAdj           = 1;
    
    % Times.
    chooseFixTime    = 0.5;                  % How long subject must look at choice to select it.
    ITI              = 1;                    % Intertrial interval.
    minFixTime       = 0.1;                  % Minimum time monkey must fixate to start trial.
    nearRewardDelay  = 0.5;                  % Delay before and after a reward is given.
    timeToFix        = intmax;               % Amount of time monkey is given to fixate.
    
    % Trial.
    currTrial        = 0;                    % Current trial.
    medReward        = 0;                    % Whether or not a medium reward was given.
    probeLocation    = '';                   % Where probe is re-presented (right or left).
    probeSpot        = 0;                    % Code for where probe is re-presented (right or left).
    screenFlip       = true;                 % Whether or not the screen should be "flipped."
    trialBorder      = [];                   % Border color of the probe for the trial.
    trialImage       = 0;                    % The neutral image used for the trial.
    trialReward      = [];                   % The reward amount(s) used for the trial.
    
    % ---------------------------------------------- %
    % ------------------- Setup -------------------- %
    % ---------------------------------------------- %
    
    % Load images
    for i = 1:size(images, 2)
        if strcmp(char(images(i)), 'ocean')
            imgOcean = imread('images/ocean.jpg', 'jpg');
        elseif strcmp(char(images(i)), 'marble')
            imgMarble = imread('images/marble.jpg', 'jpg');
        elseif strcmp(char(images(i)), 'stone')
            imgStone = imread('images/stone.jpg', 'jpg');
        elseif strcmp(char(images(i)), 'wheat')
            imgWheat = imread('images/wheat.jpg', 'jpg');
        end
    end
    
    % Saving.
    prepare_for_saving;
    
    % Window.
    window = setup_window;
    
    % Eyelink.
    setup_eyelink;
    
    % ---------------------------------------------- %
    % ------------ Main experiment loop ------------ %
    % ---------------------------------------------- %
    
    running = true;
    while running
        run_single_trial;
        
        print_stats();
        
        % Check for pausing or quitting during ITI.
        startingTime = GetSecs;
        while ITI > (GetSecs - startingTime)
            key = key_check;
            
            % Pause experiment.
            if key.pause == 1
                pause(key);
            end
            
            % Exit experiment.
            if key.escape == 1
                running = false;
            end
        end
    end
    
    Screen('CloseAll');
    
    % ---------------------------------------------- %
    % ----------------- Functions ------------------ %
    % ---------------------------------------------- %
    
    % Determines if the eye has fixated within the given bounds
    % for the given duration before the given timeout occurs.
    function [fixation, area] = check_fixation(type, duration, timeout)
        startTime = GetSecs;
        
        % Keep checking for fixation until timeout occurs.
        while timeout > (GetSecs - startTime)
            [xCoord, yCoord] = get_eye_coords;
            
            % Determine if one, two, or three locations are being tracked.
            if strcmp(type, 'single')
                % Determine if eye is within the fixation boundary.
                if xCoord >= fixBoundXMin && xCoord <= fixBoundXMax && ...
                   yCoord >= fixBoundYMin && yCoord <= fixBoundYMax
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(fixBoundXMin, fixBoundXMax, ...
                                                    fixBoundYMin, fixBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'single';
                        
                        return;
                    end
                end
            elseif strcmp(type, 'double')
                % Determine if eye is within the left option boundary.
                if xCoord >= leftBoundXMin && xCoord <= leftBoundXMax && ...
                   yCoord >= leftBoundYMin && yCoord <= leftBoundYMax
                    if probeSpot == 1
                        draw_feedback('left', 'probe', colorWhite);
                    else
                        draw_feedback('left', 'neutral', colorWhite);
                    end
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(leftBoundXMin, leftBoundXMax, ...
                                                    leftBoundYMin, leftBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'left';
                        
                        return;
                    else
                        display_choice;
                    end
                % Determine if eye is within the right option boundary.
                elseif xCoord >= rightBoundXMin && xCoord <= rightBoundXMax && ...
                       yCoord >= rightBoundYMin && yCoord <= rightBoundYMax
                    if probeSpot == 2
                        draw_feedback('right', 'probe', colorWhite);
                    else
                        draw_feedback('right', 'neutral', colorWhite);
                    end
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(rightBoundXMin, rightBoundXMax, ...
                                                    rightBoundYMin, rightBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'right';
                        
                        return;
                    else
                        display_choice;
                    end
                end
            else
                disp('Fixation being checked with an illegal value for the "type" parameter.');
            end
        end
        
        % Timeout reached.
        fixation = false;
        area = 'none';
    end
    
    % Generates a new probe.
    function create_probe()
        probeSpot = rand_int(2);
        
        % Choose a random reward amount for this trial.
        randInt1 = rand_int(5);
        
        if randInt1 == 1
            trialReward = rewardVSmall;
            trialBorder = colorOrange;
            medReward = 0;
        elseif randInt1 == 2
            trialReward = rewardSmall;
            trialBorder = colorYellow;
            medReward = 0;
        elseif randInt1 == 3
            trialReward = rewardMedium;
            trialBorder = colorGray;
            medReward = 1;
        elseif randInt1 == 4
            trialReward = rewardLarge;
            trialBorder = colorBlue;
            medReward = 0;
        elseif randInt1 == 5
            trialReward = rewardVLarge;
            trialBorder = colorGreen;
            medReward = 0;
        end
        
        % Choose a random neutral image for this trial (possibly one choice).
        randInt2 = rand_int(size(images, 2));
        pickedImage = char(images(randInt2));
        
        if strcmp(pickedImage, 'marble')
            trialImage = imgMarble;
        elseif strcmp(pickedImage, 'ocean')
            trialImage = imgOcean;
        elseif strcmp(pickedImage, 'stone')
            trialImage = imgStone;
        elseif strcmp(pickedImage, 'wheat')
            trialImage = imgWheat;
        end
    end
    
    % Draws the choice on the screen.
    function display_choice()
        % Show probe on left side.
        if probeSpot == 1
            probeLocation = 'left';
            
            Screen('PutImage', window, trialImage, [leftStimXMin, leftStimYMin, ...
                                                    leftStimXMax, leftStimYMax]);
            if strcmp(experimentType, 'training1')
                Screen('FrameRect', window, trialBorder, [leftStimXMin - bordThick, ...
                                                          leftStimYMin - bordThick, ...
                                                          leftStimXMax + bordThick, ...
                                                          leftStimYMax + bordThick], ...
                                                          bordThick);
            end
            
            Screen('FillRect', window, colorGray, [rightGreyXMin rightGreyYMin ...
                                                   rightGreyXMax rightGreyYMax]);
        % Show probe on right side.
        else
            probeLocation = 'right';
            
            Screen('PutImage', window, trialImage, [rightStimXMin, rightStimYMin, ...
                                                    rightStimXMax, rightStimYMax]);
            if strcmp(experimentType, 'training1')
                Screen('FrameRect', window, trialBorder, [rightStimXMin - bordThick, ...
                                                          rightStimYMin - bordThick, ...
                                                          rightStimXMax + bordThick, ...
                                                          rightStimYMax + bordThick], ...
                                                          bordThick);
            end
            
            Screen('FillRect', window, colorGray, [leftGreyXMin leftGreyYMin ...
                                                   leftGreyXMax leftGreyYMax]);
        end
        
        if screenFlip
            Screen('Flip', window);
        end
    end
    
    % Draws the probe in the center of the screen.
    function display_probe()
        Screen('PutImage', window, trialImage, [centerProbeXMin, ...
                                                centerProbeYMin, ...
                                                centerProbeXMax, ...
                                                centerProbeYMax]);
                                            
        if strcmp(experimentType, 'training1') || strcmp(experimentType, 'training2')
            Screen('FrameRect', window, trialBorder, [centerProbeXMin - bordThick, ...
                                                      centerProbeYMin - bordThick, ...
                                                      centerProbeXMax + bordThick, ...
                                                      centerProbeYMax + bordThick], ...
                                                      bordThick);
        end
        
        Screen('Flip', window);
    end
    
    % Draw colored outlines around options for feedback.
    function draw_feedback(location, type, color)
        if strcmp(location, 'left')
            if strcmp(type, 'probe')
                screenFlip = false;
                display_choice;
                
                if strcmp(experimentType, 'training1')
                    Screen('FrameRect', window, color, [leftStimXMin - bordThick - feedThick, ...
                                                        leftStimYMin - bordThick - feedThick, ...
                                                        leftStimXMax + bordThick + feedThick, ...
                                                        leftStimYMax + bordThick + feedThick], ...
                                                        feedThick);
                else
                    Screen('FrameRect', window, color, [leftStimXMin - feedThick, ...
                                                        leftStimYMin - feedThick, ...
                                                        leftStimXMax + feedThick, ...
                                                        leftStimYMax + feedThick], ...
                                                        feedThick);
                end
            else
                screenFlip = false;
                display_choice;
                Screen('FrameRect', window, color, [leftGreyXMin - feedThick, ...
                                                    leftGreyYMin - feedThick, ...
                                                    leftGreyXMax + feedThick, ...
                                                    leftGreyYMax + feedThick], ...
                                                    feedThick);
            end
        elseif strcmp(location, 'right')
            if strcmp(type, 'probe')
                screenFlip = false;
                display_choice;
                
                if strcmp(experimentType, 'training1')
                    Screen('FrameRect', window, color, [rightStimXMin - bordThick - feedThick, ...
                                                        rightStimYMin - bordThick - feedThick, ...
                                                        rightStimXMax + bordThick + feedThick, ...
                                                        rightStimYMax + bordThick + feedThick], ...
                                                        feedThick);
                else
                    Screen('FrameRect', window, color, [rightStimXMin - feedThick, ...
                                                        rightStimYMin - feedThick, ...
                                                        rightStimXMax + feedThick, ...
                                                        rightStimYMax + feedThick], ...
                                                        feedThick);
                end
            else
                screenFlip = false;
                display_choice;
                Screen('FrameRect', window, color, [rightGreyXMin - feedThick, ...
                                                    rightGreyYMin - feedThick, ...
                                                    rightGreyXMax + feedThick, ...
                                                    rightGreyYMax + feedThick], ...
                                                    feedThick);
            end
        end
        
        Screen('Flip', window);
        screenFlip = true;
    end
    
    % Draws a thin line on top of the invisible fixation boundaries.
    function draw_fixation_bounds()
        Screen('FrameRect', window, colorYellow, [fixBoundXMin fixBoundYMin ...
                                                  fixBoundXMax fixBoundYMax], 1);
        Screen('FrameRect', window, colorYellow, [leftBoundXMin leftBoundYMin ...
                                                  leftBoundXMax leftBoundYMax], 1);
        Screen('FrameRect', window, colorYellow, [rightBoundXMin rightBoundYMin ...
                                                  rightBoundXMax rightBoundYMax], 1);
        
        Screen('Flip', window);
    end
    
    % Draws the fixation point on the screen.
    function draw_fixation_point(color)
        Screen('FillOval', window, color, [centerX - dotRadius + fixAdj; ...
                                           centerY - dotRadius; ...
                                           centerX + dotRadius - fixAdj; ...
                                           centerY + dotRadius]);
        Screen('Flip', window);
    end
    
    % Checks if the eye breaks fixation bounds before end of duration.
    function fixationBreak = fix_break_check(xBoundMin, xBoundMax, ...
                                             yBoundMin, yBoundMax, ...
                                             duration)
        fixStartTime = GetSecs;
        
        % Keep checking for fixation breaks for the entire duration.
        while duration > (GetSecs - fixStartTime)
            [xCoord, yCoord] = get_eye_coords;
            
            % Determine if the eye has left the fixation boundaries.
            if xCoord < xBoundMin || xCoord > xBoundMax || ...
               yCoord < yBoundMin || yCoord > yBoundMax
                % Eye broke fixation before end of duration.
                fixationBreak = true;
                
                return;
            end
        end
        
        % Eye maintained fixation for entire duration.
        fixationBreak = false;
    end
    
    % Returns the current x and y coordinants of the given eye.
    function [xCoord, yCoord] = get_eye_coords()
        sampledPosition = Eyelink('NewestFloatSample');
        
        xCoord = sampledPosition.gx(trackedEye);
        yCoord = sampledPosition.gy(trackedEye);
    end
    
    % Checks to see what key was pressed.
    function key = key_check()
        % Assign key codes to some variables.
        stopKey = KbName('ESCAPE');
        pauseKey = KbName('RightControl');
        
        % Make sure default values of key are zero.
        key.pressed = 0;
        key.escape = 0;
        key.pause = 0;
        
        % Get info about any key that was just pressed.
        [~, ~, keyCode] = KbCheck;
        
        % Check pressed key against the keyCode array of 256 key codes.
        if keyCode(stopKey)
            key.escape = 1;
            key.pressed = 1;
        end
        
        if keyCode(pauseKey)
            key.pause = 1;
            key.pressed = 1;
        end
    end
    
    % Makes a folder and file where data will be saved.
    function prepare_for_saving()
        cd(rewardRepeatData);
        
        % Check if cell ID was passed in with monkey's initial.
        if numel(monkeysInitial) == 1
            initial = monkeysInitial;
            cell = '';
        else
            initial = monkeysInitial(1);
            cell = monkeysInitial(2);
        end
        
        dateStr = datestr(now, 'yymmdd');
        filename = [initial dateStr '.' cell '1.RR.mat'];
        folderNameDay = [initial dateStr];
        
        % Make and/or enter a folder where .mat files will be saved.
        if exist(folderNameDay, 'dir') == 7
            cd(folderNameDay);
        else
            mkdir(folderNameDay);
            cd(folderNameDay);
        end
        
        % Make sure the filename for the .mat file is not already used.
        fileNum = 1;
        while fileNum ~= 0
            if exist(filename, 'file') == 2
                fileNum = fileNum + 1;
                filename = [initial dateStr '.' cell num2str(fileNum) '.RR.mat'];
            else
                fileNum = 0;
            end
        end
        
        saveCommand = ['save ' filename ' ' varName];
    end

    % Prints current trial stats.
    function print_stats()
        % Convert percentages to strings.
        percentCorrStr  = strcat(num2str(percentCorrect), '%');
        trialCountStr   = num2str(currTrial);
        
        home;
        disp('             ');
        disp('****************************************');
        disp('             ');
        fprintf('Total trials: % s', trialCountStr);
        disp('             ');
        disp('             ');
        disp('----------------------------------------');
        disp('             ');
        fprintf('Total correct: % s', percentCorrStr);
        disp('             ');
        disp('             ');
        disp('****************************************');
    end
    
    function k = pause(k)
        disp('             ');
        disp('\\\\\\\\\\\\\\\\\\\\\\\\\\\\          /////////////////////////////');
        disp(' \\\\\\\\\\\\\\\\\\\\\\\\\\\\ PAUSED /////////////////////////////');
        disp('  |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
        
        while k.pressed == 1
            k = key_check;
        end
        
        pause = 1;
        while pause == 1 && k.escape ~= 1
            k = key_check;
            
            if k.pause == 1
                pause = 0;
            end
        end
        
        while k.pressed == 1
            k = key_check;
        end
        
        disp('             ');
        disp('  ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
        disp(' /////////////////////////// UNPAUSED \\\\\\\\\\\\\\\\\\\\\\\\\\\');
        disp('///////////////////////////            \\\\\\\\\\\\\\\\\\\\\\\\\\\');
        disp('             ');
    end
    
    % Returns a random int between 1 (inclusive) and integer (inclusive).
    function randInt = rand_int(integer)
        randInt = floor(rand(1) * integer + 1);
    end
    
    % Rewards monkey using the juicer with the passed duration.
    function reward(rewardDurationsArray)
        % Get a reference the juicer device and set reward duration.
        daq = DaqDeviceIndex;
        
        % Determine if multiple rewards should be given.
        numOfRewards = size(rewardDurationsArray, 2);
        if numOfRewards > 1
            multRewards = 1;
        else
            multRewards = 0;
        end
        
        for index = 1:numOfRewards
            % Open juicer.
            DaqAOut(daq, 0, .6);
            
            % Keep looping to keep juicer open until reward end.
            startTime = GetSecs;
            while (GetSecs - startTime) < rewardDurationsArray(index)
            end
            
            % Close juicer.
            DaqAOut(daq, 0, 0);
            
            % Pause between multiple rewards.
            if multRewards
                % Don't pause after the last reward in a sequence.
                if index ~= numOfRewards
                    WaitSecs(rewardPause);
                end
            end
        end
    end
    
    % Does exactly what you freakin' think it does.
    function run_single_trial()
        currTrial = currTrial + 1;
        
        create_probe;
        
        if currTrial == 1
            WaitSecs(ITI);
        end
        
        display_probe;
        
        WaitSecs(nearRewardDelay);
        
        % Give initial probe reward(s).
        reward(trialReward);
        
        WaitSecs(nearRewardDelay);
        
        draw_fixation_point(colorYellow);
        
        % Check for fixation.
        [fixating, ~] = check_fixation('single', minFixTime, timeToFix);
        
        if fixating
            display_choice;
            
            fixatingOnTarget = false;
            while ~fixatingOnTarget
                % Check for fixation on either targets.
                [fixatingOnTarget, area] = check_fixation('double', chooseFixTime, timeToFix);
                
                if fixatingOnTarget
                    if strcmp(area, 'left')
                        if strcmp(probeLocation, 'left')
                            draw_feedback('left', 'probe', colorCyan);
                            WaitSecs(nearRewardDelay);
                            reward(trialReward);
                            
                            % Count as "correct" trial if medium probe not offered.
                            if medReward == 0
                                numCorrTimes = numCorrTimes + 1;
                            end
                        else
                            draw_feedback('left', 'neutral', colorCyan);
                            WaitSecs(nearRewardDelay);
                            reward(rewardMedium);
                        end
                        
                        choiceMade = 'left';
                    elseif strcmp(area, 'right')
                        if strcmp(probeLocation, 'right')
                            draw_feedback('right', 'probe', colorCyan);
                            WaitSecs(nearRewardDelay);
                            reward(trialReward);
                            
                            % Count as "correct" trial if medium probe not offered.
                            if medReward == 0
                                numCorrTimes = numCorrTimes + 1;
                            end
                        else
                            draw_feedback('right', 'neutral', colorCyan);
                            WaitSecs(nearRewardDelay);
                            reward(rewardMedium);
                        end
                        
                        choiceMade = 'right';
                    end
                    
                    percentCorrect = round((numCorrTimes / currTrial) * 100);
                    save_trial_data;
                    
                    % Clear screen.
                    Screen('FillRect', window, colorBackground, ...
                           [0 0 (centerX * 2) (centerY * 2)]);
                    Screen('Flip', window);
                end
            end
        end
        
        % send_and_save;
    end

    % Saves trial data to a .mat file.
    function save_trial_data()
        % Save variables to a .mat file.
        data(currTrial).trial = currTrial;               % The trial number for this trial.
        data(currTrial).experimentType = experimentType; % The type of experiment.
        data(currTrial).probeLocation = probeLocation;   % Which side the probe was on.
        data(currTrial).choice = choiceMade;             % Which side was chosen.
        data(currTrial).numCorr = numCorrTimes;          % Number of times the "correct" choice was made.
        data(currTrial).percentCorr = percentCorrect;    % Percent of times the "correct" choice was made.
        data(currTrial).reward = trialReward;            % The reward duration(s) the monkey was given.
        data(currTrial).rewardVSmall = rewardVSmall;     % Smallest reward duration(s).
        data(currTrial).rewardSmall = rewardSmall;       % Small reward duration(s).
        data(currTrial).rewardMedium = rewardMedium;     % Medium reward duration(s).
        data(currTrial).rewardLarge = rewardLarge;       % Large reward duration(s).
        data(currTrial).rewardVLarge = rewardVLarge;     % Largest reward duration(s).
        data(currTrial).interRewardPause = rewardPause;  % Pause time between rewards.
        data(currTrial).chooseTime = chooseFixTime;      % Time monkey most look at the option to select it.
        data(currTrial).ITI = ITI;                       % Intertrial interval.
        data(currTrial).minFixTime = minFixTime;         % Time monkey must fixate to start trial.
        data(currTrial).timeToFix = timeToFix;           % Maximum time allowed to initiate trial.
        data(currTrial).images = images;                 % Image(s) used for the neutral image(s).
        data(currTrial).trackedEye = trackedEye;         % The eye being tracked.
        
        eval(saveCommand);
    end
    
    % Sets up the Eyelink system.
    function setup_eyelink()
        abortSetup = false;
        setupMode = 2;
        
        % Connect Eyelink to computer if unconnected.
        if ~Eyelink('IsConnected')
            Eyelink('Initialize');
        end
        
        % Start recording eye position.
        Eyelink('StartRecording');
        
        % Set some preferences.
        Eyelink('Command', 'randomize_calibration_order = NO');
        Eyelink('Command', 'force_manual_accept = YES');
        
        Eyelink('StartSetup');
        
        % Wait until Eyelink actually enters setup mode.
        while ~abortSetup && Eyelink('CurrentMode') ~= setupMode
            [keyIsDown, ~, keyCode] = KbCheck;
            
            if keyIsDown && keyCode(KbName('ESCAPE'))
                abortSetup = true;
                disp('Aborted while waiting for Eyelink!');
            end
        end
        
        % Put Eyelink in output mode.
        Eyelink('SendKeyButton', double('o'), 0, 10);
        
        % Start recording.
        Eyelink('SendKeyButton', double('o'), 0, 10);
    end
    
    % Sets up a new window and sets preferences for it.
    function window = setup_window()
        % Print only PTB errors.
        Screen('Preference', 'VisualDebugLevel', 1);
        
        % Suppress the print out of all PTB warnings.
        Screen('Preference', 'Verbosity', 0);
        
        % Setup a screen for displaying stimuli for this session.
        window = Screen('OpenWindow', monkeyScreen, colorBackground);
    end
end