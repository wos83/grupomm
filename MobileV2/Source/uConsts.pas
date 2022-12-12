unit uConsts;

interface

uses
  System.SysUtils,
  System.IOUtils;

const
  { todo -o@WOS83 -cGoogle Maps:Google Maps API (Web)
    Criada em 15/11/2022 - 16:58:16
    Email: grupomm.dev@gmail.com }
  cGoogleMapsWebAPI = 'AIzaSyB8Nc2NQIBhkNwj1-50zbPKUmIqxYq5BXY';
  cOSMMapsWebAPI = 'cff72305f0eb430eb174a1ab4af0bff9';

  cConnDef = 'FDConnectionDefs.ini';

  cImageCarOn48 = 'images/car-on-48.png';
  cImageCarOff48 = 'images/car-off-48.png';

  cImageUrlCarOn48 = 'http://i.imgur.com/Hd62TQK.png';
  cImageBase64CarOn48 = //
     //'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABHNCSVQICAgIfAhkiAAACN5JREFUaIHFmn9Q1GUex1+P68IGLGmwKEIqAsJ5zrn4I0zxxySUo3hz9uNwpuzOppwTY6rpps5rru6qm82yQk5DafxxWV1zd45n9st0pfT0KO2gRERBXBTFRTBd2oXdhe9zf6xuu+xPdql7/wPP+/Pj+/7s8zz7' + //
     'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABHNCSVQICAgIfAhkiAAACN5JREFUaIHFmn9Q1GUex1+P68IGLGmwKEIqAsJ5zrn4I0zxxySUo3hz9uNwpuzOppwTY6rpps5rru6qm82yQk5DafxxWV1zd45n9st0pfT0KO2gRERBXBTFRTBd2oXdhe9zf6xuu+xPdql7/wPP+/Pj+/7s8zz7' + //
     'fJ8PCJ1BxVBg2jk5X2vn0fabxdyuOBKvxBOrCJdN40SO7KE3+TvZMdrCnpOjxaa2EZwYiueKaAu4s1G+cnyMWN2eyE2DicsxS/OYazxZPVG8E83zIy6g8JRc3ThKrG0bQXw0AqZckC0xfTxydJw4EEn8sEiC5jfJf+3PERuiFQ/wdZqYcHScMBY1yiciiR/UDHSs6R921+phjbXpItuffWyPhkXafGZN+QWjb51EUmom/X1OLrc1cu5sLc' + //
     'b6nXzESWzDFb/5F5yS2405YsUPVoC+TZ6pSxcTfHjbSJ65ax3zZv8qrDx/fedxXmipxKLu97EVNcpN+3LFqnA1hV3AvCa55/NsUTyQf2384zywbF24z/seUvLUywVsl1/4mBackqXGHFEZTpqw9kBRo/ztQPGx/YKd89+KTDyAELz89GHWpv3Gx1Q9UbzRsaY/Lpw0qvjC0DVYY4XRGstwT25n0bsU5C8LV25A5E1ZRHzjWT6zfePmpIBD' + //
     'WeLOthHizVDxIdUXNcoNZi0aT25j9hpmzfhlRIL9ofThbdzbN9mLqxkvZsxolXeEig1ZwFe3ipWe49ttKdx3zwt+faWU2O127HY7fX19oVJ74clH/J5n5aHihgczzjkjlx7KFGpP7ukl/nPW1tZSXl5OR0cHw4cPR6PREB8fT1ZWFosXLyYvLy+okMxRP+XpxKWstexyc8fHiMlBQoDQM1DqOZhkS/S7dKqrqyksLEQIwapVq8jJySE2Np' + //
     'a8vDwuXLhAcXExpaWldHd3B33Y0nuf9xr3qhF3nJa/jriA1ltEvud4kW6e+3dFUWhvb2fHjh08+OCDlJSUUFlZycKFC8nNzWXcuHE89thjrF+/ngMHDnDixAkWLVpEQ0MDiuL/IJuQ8hOm25K8OKeKoAUEPQc0Tvp71d8X+X7R35k57W4AVq9ezbZt2+jp6QEgLy8PnU5HXFwcly9fBmDq1KlotVq0Wi0qlYqqqiqsVislJSXMmTPHHZOQ' + //
     'kOB+5st/Wco66x73WN8mW+rSRWYgjUH3gKd4gNSMKQBYrVbq6+vd4sG1Bwbi8OHDfvOWl5dTXl6OWq2moKCAiooKJk92LffU5Alg/d63WyNGBNMYcAl1rOnXDOSGqVyz1dDQQF1dXbC8YcHpdFJdXU1ZWZn7w0gdPdHL55qGBH+xbk2R2D788EMsFot7HBcXx/jx48OQDDExMaSnp3txBw8epKOjA4C+PoeXTYrg+QIuoRSDyjaQ63PaAd' + //
     'BqtW5Or9dz//33YzKZSElJoaKigq6uLr85MzIyKC0txWQykZaWRlVVFSaTCSEEdrsrt9nc7BUT78DeFeSlPegeENL7E2hr/oqM5ByWL1+O2Wyms7OTgoICysrKsNls5Ofn89BDD3HkyBHAdbBJKd2/FxcXs27dOsxmMxkZGaxYsYK9e/dy2223MXGia+m0dXkXoO2VFgg8DUG/hTI76TqTzC03xo/GFvLsE594+dTW1jJz5kwcDgd6vZ79' + //
     '+/cTGxvrk0tKSWdnJ9OnT+fKlSukp6dTU1NDYmKi14wueDaJ43HX3OO5zfKjg1licSCNQWcg1SLrzySLuTfGH397hGcH+Oj1ejZv3syhQ4dYuXIlSUlJBIJWq2XLli3s3r2bkpIS0tLSvOxNF7/xEg+g7ueDYBqDzsDcZnnPwSzxT0/uvds3cce8h318nU4narXah/cHh8NBTEyMD/+n1+5io8PoHmucKL1qgl5Ygp7EB7PEzlQLPZ7ci8' + //
     'an/PqGKx7wK76x9aiXeIBp52VNqFwh30YnX5RVnuP6OAubt/rOQLR4but9PlyPmt+FigvrSjnmGtaLN+N1Q3pr2ussLCobjMaAeP71hWyw7/fiprTK4/s3KUtx7VMB9AE9wFWdQeU+q8O6keW3yistyd5Xyl3te8m1aMjJnh2VeEPFEip6P/XihISutcrybkgAtLh+JgJJQJrNKBNtRnk1vnBYf1gFtCSLY7NbZNH5kWKsJ/++2ciwb45H' + //
     'dDtrvlTP46/O5m151MeW1iw/aKqV/w4SfhMw0maU7WE3tna9qcxN6aZ3IL/Wsouf/TGOf+z8Q1h5TF1NvFTxc2Zt1/NJ7Fkfe0a7PF+3VXk1jFQJgHZQfaH5TXLZZ9nib4HsakWwsC+LgowFpI7KZlT6JBy933HpYiPnLzawr83If+I6AuaPc9Bvfq6/qBdkmJL+O+jeaKD+0FAg+bR89+Q2JWQn4jr6gCOD7o1+ni2WjP0WS2jPwSHznD' + //
     'w5CPEAF3QGlRJRczf9qoy+IeSBpG7sNZVKaWhPN7oBE0TYnT6SIT5ecEpujyTWH5wtMqw24nVYgXqdQSUhwgIAjDliRU4HgXdkmMg4K784856yO0z3bqBOZ1DZbxARFwBwk0PeHU38mCtc+7JKCfm6cB0XcYl3epJRFVCXLg4XNcrXIo3vOilfCsOtF/haZ1Cd1hlUPv34qAoA2JcrnpxyQbYONu7WZvlp2wdKsLfNflwb9ajOoPo2kFPQ' + //
     'C0242LdBmZT+ouo7hyrI3c8D4y/JS0e3KIYAZolrubTqDCpHAB83op4BcDUA5jXJsN4lNE7k6fXKAwHMl4EvdQZVUzjiYYhmAGBfrvjz9HNy2bGxwRuyN5+VO8+7locnrgItOoNq0AfkkBUA8FGlMjXrOVWPReP/GpjZJptrtikbPSgrLuH++zBhYEiW0A2kGFTOGa3S7y1nhBVnzUblketDO9AIHItGPAzxDAAYc0Tl7Bb5wOEJYpaXwS' + //
     'S34noBOwe06Qwq/y3qQWLICwDY9aYyZ9Izqp7OBGIAMk3yWM3byiu4vlkG96ebEIj6fyUCoWZN/9glv1ed0l2VrZ+/oeh1BpXPZWgo8IMV8GNhSDfx/wP/A/0JPXlYzJ0xAAAAAElFTkSuQmCC';

  cImageUrlCarOff48 = 'http://i.imgur.com/KCYhik5.png';
  cImageBase64CarOff48 = //
     //'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAGu0lEQVRoge2Zf0zU5x3HX19+BzhtsLAJRxGnYuu2glk0a5DKYnULZK1LE9sYDdKsBowZf/Sfqcn+WLqtjd3QpGwBV1bdkqVpRrqGqNXMhlTqNMVax1QyyI3ANfyw2kOOO+DuvT++cN4dX+4XZ12WvZMnuXu+nx/v9+f5cc/3OYMkQZAH1AA7' + //
     'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAGu0lEQVRoge2Zf0zU5x3HX19+BzhtsLAJRxGnYuu2glk0a5DKYnULZK1LE9sYDdKsBowZf/Sfqcn+WLqtjd3QpGwBV1bdkqVpRrqGqNXMhlTqNMVax1QyyI3ANfyw2kOOO+DuvT++cN4dX+4XZ12WvZMnuXu+nx/v9+f5cc/3OYMkQZAH1AA7' + //
     'gBKgEFgJTAPOuXYLeB/4m2H2P3wIvic4L5gRKMbmErwtWP0wiX9TcDoO0lbNKzgmWPFVk6+bSx6ZYHq6lJISi5BBQflXQTxF8IYlibQ0qbpaOnZMunZNGhuTJGl2Vhoeli5elA4fljZsWEzEPcGPHrSA5gWJDUN6/nmpr08x48wZ6cknrUT4ZG4ED4T8SwsSrlghnTsXO/Fg+P3Sa69JqalWC3xDsslvXDDn16+X+vsTIx+Mzk4pJydcRL' + //
     '8gO5kCLoQkyM+XHI6lk5/Hu+9aLfZDySL/g5DAqalSV1fyyM/jyJFwAXeTsr0KPg4JvHfvohz8fr88Ho88Ho9mZmbiE+D1SiUl4SJ+Ho2fEYW8HRgM2GVmwq1bUFKywPbq1as0NzczOjpKWloaWVlZ5OTksGbNGmpqaqioqIherVOnYO/e4J4bBjwRySUlSsgfEixyxw5L8hcuXGDbtm0YhkFDQwNlZWVkZmZSUVHB8PAwtbW1NDY2MjEx' + //
     'ETnbCy/A8uXBPY8L1kbhuDgE74cM6VtvBUbc5/PJ6XTq5MmTstvtamhokNvtltfrVVtbmw4dOjQ3M7y6efOmqqqqVFlZqd7eXvl8vsWn0osvhk+jn0TiGG0K9RI8hIODUFwMwIEDB2hvb2dqagqAiooK8vPzyc7OZmxsDICNGzdis9mw2WykpqbS2trK5OQku3btYsuWLQGf3Nzc+0nb26G+PpjGMQOa4qh7iIA7IbvPXOXu3bunqqoqmS' + //
     'aJt/T0dFVXV+v69ev3R+CDD8JH4J1EyWeFBFq5MpDj8uXLWrZs2ZIFzLetW7fK7XabwXt7wwV8FIlnpEUc+sznC3zs7OzE5XIFvmdnZ7Nq1aoYygIZGRnY7faQvq6uLkZHR80vs7PhLhGnedpiDwxwCzxAFgDj42bwtDRsNlvArry8nN27d+NwOCgoKOD48ePcvn3bMmZpaSmNjY04HA6KiopobW3F4XBgGAZer9c0cjrD3b5ISMAcPgdK' + //
     'AfD7zUW8ejV79uxhZGSE8fFxKisrOXjwIG63m82bN1NfX093dzcAkpAU+FxbW8vRo0cZGRmhtLSUffv2cfbsWTZt2sS6devMjIODVhwSg+CdkPnY0rJg1+vp6VFGRoYAlZeXa3x8XBMTEwuay+XSwMCA8vLyBMhut2toaEgulys04M6d4Wvgx0sR0BQSbPv2BQL8fr/a29tVX1+vS5cuRTosSJI6OjpUV1en06dPL3w4NWV1Mk38aC0olv' + //
     'mScf+t68YNS2LT09NRyc/D6/VaP3jzzXDyvQmTDxJxPiToc8/FTDQuTExIBQXhAl5JhoDtIUENQ+roSL6A/fvDyd8WPLJkAXMizoUEz801X9yThZaWBe/Hg+ZR+htAGbAeWAMUATmJCHhCMBWSpLBQunJl6eTb2szrl6DYLhgohGeArYu0bwOZEP04DYAB/wSOhHQ6nfD00+YZPhF4vdDUBC+/DDMzgW4/zP4SXnXCTATvPOBbRPmVDoHM' + //
     'O6EPw4daID31VOyvmbOz0okTkt1ueT/UDb9j8cqHt2WxKzBFrAI+A2yWBmvXwrPPQnU1FBVBYaFZaacTHA7o7DTbIkeNcfisGJo85iEvFvTEJWBOxEvAiXj9omEW3HVQ/ycYid2F7pjWQDAM+D3mFXlScQaOx0EeYBjwxz0CAIKvAf8AHk3EPxxD0FUMP4vDZQLoART3CAAYZqX2J+Ibjmn4Yje8EYfLJGbxBDFuo1Yw4C/AHxP1n8cpeL' + //
     '0LXNEtAbPynwLeIB6JQ7Acsxr2aLZW6IP3yqA5RnMn0A/4gjsTHgEAA74E9hH7thfAJAzVwG9jMPUA14A+wsjDEgUAGHAeaInHR+D7Nbz6r6CpYAEf4ACuAHci5F86ZF6FXwXWxWL/CfzhO/D24uFwAv8mhn8ykyJgLutm4CKQGsnuDtwohYNfWkwHYAwYAKZizbvkKTQPA/4O/CqSjQ88P4VfWJC/i7mv9xIH+bm8yYMgHVOI5VX0efjN' + //
     'M/DXoK5JzIpbH44eBgQbBJ7wU+bn8DH3T5HfBb5OkguYNAheCSY/DXe/DzuBSuAxkjh1HwgEKTPw0byAP8NhzNfDaBdp/z3oh8fuwId98Drz15P/x/8g/gOgURr9Y9Tq6gAAAABJRU5ErkJggg==';

  cIgnitionColor = $FF344050;
  cIgnitionOnColor = $FF196F3D;
  cIgnitionOffColor = $FFC0392B;

  cIgnitionOnText = '🟢 Ligado';
  cIgnitionOffText = '🔴 Desligado';

  cBatteryOnColor = $FF196F3D;
  cBatteryOffColor = $FFC0392B;

  cBatteryOnText = '🟢 Conectada';
  cBatteryOffText = '🔴 Desconectada';

implementation

end.
