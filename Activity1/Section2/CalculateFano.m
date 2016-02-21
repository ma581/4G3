function  [FanoFactor] = CalculateFano(spikeTrain,window, dt)

% Indexes
l = length(spikeTrain);
windowWidth = window/dt;

% Calculating counts in window
spikeCount = zeros(1,l/windowWidth);
j = 1;
for i = 1:l-windowWidth
    spikeCount(i) = sum(spikeTrain(1,i:i+windowWidth));
end

% FanoFactor
spikeCountMean = mean(spikeCount);
spikeCountVar = std(spikeCount)^2;
FanoFactor = spikeCountVar/spikeCountMean;
end

