function [S, C, H, G] = generate_code()
    P = [1 1 1 0; 1 0 1 1; 1 1 0 1];
    G = [eye(8),[P'; zeros(4,3)],[zeros(4,3); P'],[0; 1; 1; 1; 0; 1; 1; 1]];
    P = [1 1 1; 1 0 1; 1 1 0];
    H = [P zeros(3) [0; 1; 1]; 
         0 1 1 0 0 0 1; 
         zeros(3) P [0; 1; 1]; 
         0 0 0 0 1 1 1; 
         eye(7)];
    
    % Vetor auxiliar
    v = zeros(1, 15);
    
    % Casos de 0 bits altos na síndrome
    % Vetor de erros nulo 
    C = zeros(1, 15);
    S = zeros(1, 7);
    
    % Casos de 1 bit alto na síndrome
    % Erro em 1 bit de paridade
    for i = 9:15
        v(i) = 1;
        C = [C; v];
        S = [S; mod(v*H,2)];
        v(i) = 0;
    end

    % Casos de 2 bits altos na síndrome
    % Erro em 2 bits de mensagem em um único bloco de Hamming
    for i = 1:3
        for j = i+1:4
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end

    for i = 5:7
        for j = i+1:8
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end

    % Erro em 1 bit de paridade e cada bloco de Hamming 
    for i = 9:11
        for j = 12:14
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end
    
    % Casos de 3 bits altos na síndrome
    % Erro em 1 bit de mensagem em um dos blocos de Hamming
    for i = 1:8
        v(i) = 1;
        C = [C;v];
        S = [S; mod(v*H,2)];
        v(i) = 0;
    end
    
    % 2 erros nos bits (b2, b3 b4) em um bloco de Hamming e 1 erro
    % de bit de paridade no outro bloco
    for i = 2:3
        for j = i+1:4
            for k = 12:14
                v(i) = 1;
                v(j) = 1;
                v(k) = 1;
                C = [C;v];
                S = [S; mod(v*H,2)];
                v(i) = 0;
                v(j) = 0;
                v(k) = 0;
            end
        end
    end
    
    for i = 6:7
        for j = i+1:8
            for k = 9:11
                v(i) = 1;
                v(j) = 1;
                v(k) = 1;
                C = [C;v];
                S = [S; mod(v*H,2)];
                v(i) = 0;
                v(j) = 0;
                v(k) = 0;
            end
        end
    end
    
    % 1 erro de paridade em cada bloco de Hamming e 1 erro no bit de
    % paridade adicional
    v(15) = 1;
    for i = 9:11
        for j = 12:14
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end
    v(15) = 0;
    
    % Casos de 4 bits altos na síndrome 
    % 1 erro em b1 em um bloco de Hamming e 1 erro no bit de paridade
    % adicional
    v(15) = 1;
    v(1) = 1;
    C = [C;v];
    S = [S; mod(v*H,2)];
    v(1) = 0;
    v(5) = 1;
    C = [C;v];
    S = [S; mod(v*H,2)];
    v(5) = 0;
    v(15) =0;
    
    % 1 erro em (b2, b3, b4) em cada bloco de Hamming
    for i = 2:4
        for j = 6:8
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end
    
    % 1 erro de bit de mensagem em um bloco de Hamming e 1 erro de bit de
    % paridade no outro
    for i = 1:4
        for j = 12:14
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end
    
    for i = 5:8
        for j = 9:11
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end
   
    % Casos de 5 bits altos na síndrome  
    % 1 erro em b1 em um bloco de Hamming e 2 erros de bit de mensagem
    % no outro
    v(1) = 1;
    for i = 5:7
        for j = i+1:8 
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 0;
        end
    end
    v(1) = 0;
    
    v(5) = 1;
    for i = 1:3
        for j = i+1:4
            v(i) = 1;
            v(j) = 1;
            C = [C;v];
            S = [S; mod(v*H,2)];
            v(i) = 0;
            v(j) = 1;
        end
    end
    v(5) = 0;
    
    % 1 erro em (b2, b3, b4) em cada bloco de Hamming e 1 erro no bit de
    % paridade adicional
    v(15) = 1; 
    for i = 2:4
        for j = 6:8
                v(i) = 1;
                v(j) = 1;
                C = [C;v];
                S = [S; mod(v*H,2)];
                v(i) = 0;
                v(j) = 0;
        end
    end
    v(15) = 0;
    
    % Casos de 6 bits altos na síndrome  
    % 1 erro em b1 em cada bloco de Hamming
    v(1) = 1;
    v(5) = 1;
    C = [C;v];
    S = [S; mod(v*H,2)];
    v(1) = 0;
    v(5) = 0;
    
    % 1 erro em b1 em um bloco de Hamming e 1 erro em (b2, b3, b4) no outro
    v(1) = 1;
    for i = 6:8
        v(i) = 1;
        C = [C;v];
        S = [S; mod(v*H,2)];
        v(i) = 0;
    end
    v(1) = 0;
    
    v(5) = 1;
    for i = 2:4
        v(i) = 1;
        C = [C;v];
        S = [S; mod(v*H,2)];
        v(i) = 0;
    end
    v(5) = 0;
    
    % Caso de 7 bits altos na síndrome  
    % 1 erro em b1 em cada bloco de Hamming e 1 erro no bit de
    % paridade adicional
    v(1) = 1;
    v(5) = 1;
    v(15) = 1;
    C = [C;v];
    S = [S; mod(v*H,2)];    
end