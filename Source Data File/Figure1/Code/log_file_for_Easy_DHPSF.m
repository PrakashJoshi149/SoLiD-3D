% ==== Generate Easy-DHPSF log file ====
scanRange = input('Scan range? (um)\n');
stepSize = input('Step size? (um)\n');
nFrames_per_step = input('Number of frames at each z?\n');
exposureTime = input('Camera exposure time? (ms)\n')/1000;

% ==== Robust step calculation ====
nSteps = floor(scanRange/stepSize) + 1;   % ensures integer
zValues = linspace(scanRange/2, -scanRange/2, nSteps); % symmetric scan

% ==== Preallocate ====
bookSize = nSteps * nFrames_per_step;
book = zeros(bookSize, 4);

% ==== Fill Z positions ====
idx = 1;
for k = 1:nSteps
    book(idx:idx+nFrames_per_step-1, 4) = zValues(k);
    book(idx,1:3) = -1; % marker
    idx = idx + nFrames_per_step;
end

% ==== Create filename ====
fileName = sprintf('EasyDHPSF_range%gum_stepSize%gum_FramesPerStep%d.csv', ...
                    scanRange, stepSize, nFrames_per_step);

% ==== Save dialog ====
[file, path] = uiputfile('*.csv', 'Save calibration file as', fileName);

if isequal(file,0)
    disp('User canceled save operation.');
else
    fullFilePath = fullfile(path, file);
    writematrix(book, fullFilePath);
    fprintf('File saved successfully at:\n%s\n', fullFilePath);
end
