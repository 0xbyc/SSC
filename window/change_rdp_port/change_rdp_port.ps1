<#
���ű���ǰ��������Windows8��Windows2012���ϰ汾��Windows����ϵͳ
1.���޸�RDP�˿ڵĹ����У������޸�ע���HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp���¡�PortNumber���ļ�ֵΪָ���Ķ˿ڣ�����������Remote Desktop Services���񣬲����ö˿ڶ�Ӧ�ķ���ǽ��վ������ӵ�����ǽ�����С�
2.�ڻָ�Ĭ��RDP�˿ڵĹ����У����Ƚ�֮ǰ��ӵķ���ǽ�����������Ȼ��ע����ж�Ӧ��ֵ�Ķ˿ڸĻ�3389���������Remote Desktop Services����
��Ҫǿ����������Զ���������Ĺ�����Զ�����潫���ʱ���жϣ���Ҫ�������ӣ������ö˿ڶ�Ӧ�ķ���ǽ��վ������ӵ�����ǽ�����У��˴���ӵĽ����ǲ���ϵͳ����ķ���ǽ���⣬�������ʹ�õ�������Windows Azure֮������⻯����һ��Ҫ��Ӧ�������ⲿ����ǽ(��ȫ��)�����⣬�����޸ĺ��RDP�˿ڽ����޷����ⲿ����
From:https://www.cnblogs.com/fuhj02/p/3348911.html
Collect:byc <23715018@qq.com>
Date:2018-8-7
#>
Clear 
Write-Host 
Write-Host 1���Զ���Զ������˿� -ForegroundColor 10 
Write-Host 2���ָ�ϵͳĬ�ϵ�Զ������˿� -ForegroundColor 11 
Write-Host 
Write-Host 
Write-Host "���������б�ѡ��һ��ѡ��...[1-2]�� 
$opt=Read-Host 
Switch ($opt) 
    { 
        1 { 
            Write-Host 
            Write-Host �޸�Զ�����棨Remote Desktop����Ĭ�϶˿�... -ForegroundColor Red 
            Write-Host 
            Write-Host ����������ʾ����Ҫָ���Ķ˿ںţ���ο��˿ڷ�Χ����һ��ָ���Ķ˿ںţ���Χ��1024~65535�� 
            Write-Host �ýű��޸�ע���HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp���¡�PortNumber���ļ�ֵ�� 
            Write-Host 
            # ����ָ���Ķ˿ںŲ��޸�RDPĬ�϶˿� 
            $PortNumber=Read-Host "����������Ҫָ���Ķ˿ںţ���Χ��1024~65535��" 
            $original=Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'portnumber' 
            Write-Host ��ǰRDPĬ�϶˿�Ϊ$original.PortNumber 
            $result=Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'portnumber' -Value $PortNumber 
            if($result.PrimaryStatus -eq 'OK') 
            { 
                Write-Host �Ѿ���� RDP �˿ڵ��޸ģ� -ForegroundColor Green 
            } 
            else 
            { 
                Write-Host �޸�RDP �˿�ʧ�ܣ� -ForegroundColor Red 
            } 
            #����Զ��������� 
            Write-Host �������� Remote Desktop Services ... -ForegroundColor DarkYellow 
            Restart-Service termservice -Force 
            #�����Զ���˿�ͨ������ǽ 
            Write-Host ��ӷ���ǽ���ԣ��������� RDP �˿� $PortNumber ��վ�� 
            $result=New-NetFirewallRule -DisplayName "Allow Custom RDP PortNumber" -Direction Inbound -Protocol TCP -LocalPort $PortNumber -Action Allow 
            if($result.PrimaryStatus -eq 'OK') 
            { 
                Write-Host �Ѿ���� RDP �˿ڶ�Ӧ����ǽ���Ե���ӣ� -ForegroundColor Green 
            } 
            else 
            { 
                Write-Host ���RDP �˿ڶ�Ӧ����ǽ����ʧ�ܣ� -ForegroundColor Red 
            } 
            Write-Host 
            Write-Host ��� RDP �˿��޸ģ� 
            } 
        2 { 
            Write-Host 
            Write-Host ���ڻָ�ϵͳĬ�϶˿�... 
            Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'portnumber' -Value 3389 
            Write-Host �������� Remote Desktop Services... 
            Restart-Service termservice -Force 
            Write-Host ����ɾ������ǽ����... 
            Remove-NetFirewallRule -DisplayName "Allow Custom RDP PortNumber" 
            write-host ��ɻָ��� 
           } 
     }