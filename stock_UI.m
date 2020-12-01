function stock_UI
clear;
ii = 0;
screen = get(0,'ScreenSize') ;
fig = uifigure('Position',[screen(3)/2-400,screen(4)/2-300,800,600]);

% Create Text Area
txt = uitextarea(fig,...
    'Position',[125 80 100 50],...
    'Value','stay_for_debug');

list = uilistbox(fig,...
    'Items',{'','','','','','','','','','','','','','',''},...
    'Position',[50 150 400 400],...
    'Fontsize',19,...
    'ValueChangedFcn',@select);

uibutton(fig,'push',...
    'Text', 'SUBMIT',...
    'Position',[350 50 100 30],...
    'ButtonPushedFcn',@submit);

% right top panel
toppanel = uipanel(fig,...
    'position',[500 374 250 175]);
money = uieditfield(toppanel,'numeric',...
    'position',[50 105 150 20],...
    'Limits', [1000 1000000],...
    'LowerLimitInclusive','on',...
    'UpperLimitInclusive','on',...
    'ValueDisplayFormat','%i',...
    'Value',1000);
year = uidropdown(toppanel,...
    'position',[50 45 150 20],...
    'Items',{'select the year',' 1 year',' 5 years','10 years','20 years','50 years'},...
    'ValueChangedFcn',@years);


% right low panel
lowpanel = uipanel(fig,...
    'position',[500 150 250 200]);
stock = uidropdown(lowpanel,...
    'position',[50 135 150 30],...
    'Items',{'select the stock'},...
    'ValueChangedFcn',@change);
uibutton(lowpanel,'push',...
    'Text', 'ADD',...
    'Position',[50 85 150 30],...
    'ButtonPushedFcn',@add);
uibutton(lowpanel,'push',...
    'Text', 'DELETE',...
    'Position',[50 35 150 30],...
    'ButtonPushedFcn',@delete);




% ValueChangedFcn callback
    function years(src,~)
        switch src.Value
            case ' 1 year'
                stock.Items = {'AAPL', 'MSFT', 'FB', 'ZNGA', 'NVDA', 'WBA', 'GOOG', 'PIH'};
                list.Items = {'','','','','','','','','','','','','','',''};
                ii = 0;
            case ' 5 years'
                stock.Items = {'21','22','23'};
                list.Items = {'','','','','','','','','','','','','','',''};
                ii = 0;
            case '10 years'
                stock.Items = {'31','32','33','34'};
                list.Items = {'','','','','','','','','','','','','','',''};
                ii = 0;
            case '20 years'
                stock.Items = {'41','42','43','44','45'};
                list.Items = {'','','','','','','','','','','','','','',''};
                ii = 0;
            case '50 years' 
                stock.Items = {'51','52','53','54','55','56'};
                list.Items = {'','','','','','','','','','','','','','',''};
                ii = 0;
            otherwise
                stock.Items = {''};
                list.Items = {''};
                ii = 0;
        end    
    end
    function add(~,~)
        if ii < 15
            ii = ii+1;
            list.Items{ii} = stock.Value;
            disp(stock.Value);
        end
    end
    function delete(~,~)
        if ii > 0        
            list.Items{ii} = '';
            ii = ii-1;
        end
    end
    function select(src,~)
        txt.Value = src.Value;
    end
    function change(~,~)
    end
    function error
        figure('Position',[screen(3)/2-200,screen(4)/2-150,400,300],'Menubar','none');
        uicontrol('style','pushbutton','string','error','callback','close');
    end
    function submit(~,~)
        if ii < 2
            error;
        else
            %disp(money.Value);
            %disp(year.Value);
            x = list.Items;
            %disp(x);
            for i = 15:-1:ii+1
                x(i) = [];
                disp(x);
            end
            stock_for_sharpe_adam(x);
            close(fig);
        end
    end
end
