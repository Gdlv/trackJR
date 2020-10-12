julia_command("
begin
	using Images
	using ImageMagick
	using Statistics
	using LinearAlgebra
	using ImageFiltering
	using DataFrames
end
")

julia_command("
brightness(c) = 0.3 * c.r + 0.59 * c.g + 0.11 * c.b
")

julia_command("
function convolve(M, kernel)
    height, width = size(kernel)

    half_height = fld(height,2)
    half_width = fld(width,2)

    new_image = similar(M)

    # (i, j) loop over the original image
	m, n = size(M)
    @inbounds for i in 1:m
        for j in 1:n
            # (k, l) loop over the neighbouring pixels
			accumulator = 0 * M[1, 1]
			for k in -half_height:-half_height + height - 1
				for l in -half_width:-half_width + width - 1
					Mi = i - k
					Mj = j - l
					# First index into M
					if Mi < 1
						Mi = 1
					elseif Mi > m
						Mi = m
					end
					# Second index into M
					if Mj < 1
						Mj = 1
					elseif Mj > n
						Mj = n
					end

					accumulator += kernel[k, l] * M[Mi, Mj]
				end
			end
			new_image[i, j] = accumulator
        end
    end

    return new_image
end")

julia_command("
function edgeness(img)
	Sy, Sx = Kernel.sobel()
	b = brightness.(img)

	∇y = convolve(b, Sy)
	∇x = convolve(b, Sx)

	sqrt.(∇x.^2 + ∇y.^2)
end
")

julia_command("
function trackingR(path)
	vidimg = sort(readdir(path))
	coords= Dict()
	Threads.@threads for i = 1:length(vidimg)
	    imgg= load(string(path,vidimg[i]))
			edi=edgeness(imgg)
			coords[i]=findmax(edi)
		end

			data1= DataFrame()
			data1.fr = [vidimg[j] for j=1:length(coords)]
			data1.x = [coords[j][2][2] for j=1:length(coords)]
			data1.y = [coords[j][2][1] for j=1:length(coords)]
			#data1.br= [coords[j][1] for j=1:length(coords)]
		return data1
end
")

