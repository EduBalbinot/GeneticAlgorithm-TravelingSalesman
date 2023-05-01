function drawCities(xc, yc, CITY_SIZE, i, X_MAX, Y_MAX, NUMBER_SIZE)
    cityRadius= CITY_SIZE/2;        
    eval(strjoin(["img_city" i "= imread('resources/Town_" randi([1 numel(dir(fullfile('Resources', '*.*')))-2]) ".png','BackgroundColor',[0.8 0.8 0.8]);"],''));
    x1 = xc - cityRadius;
    x2 = xc + cityRadius;
    y1 = yc - cityRadius;
    y2 = yc + cityRadius;
    eval(strjoin(["img = img_city" i ";"],''));
    [x, y] = meshgrid(1:size(img,2), 1:size(img,1));
    mask = ((x-size(img,2)/2).^2 + (y-size(img,1)/2).^2) <= (size(img,1)/2)^2;
    img(~repmat(mask, [1, 1, size(img,3)])) = 255;
    imshow(flip(img,1), 'XData', [x1 x2], 'YData', [y1 y2], 'InitialMagnification', 'fit');
    text(x1, y2, num2str(i), 'Color', 'red', 'FontSize', NUMBER_SIZE, 'FontWeight', 'bold');
    axis([0 X_MAX 0 Y_MAX])
    set(gca, 'Visible', 'on');
    set(gca, 'YDir', 'normal');
end