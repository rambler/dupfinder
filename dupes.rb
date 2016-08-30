#!/usr/bin/ruby

require 'digest/sha2'

def checksum(file)
    Digest::SHA256.file(file).hexdigest
end

# find /fsys/a /fsys/b /fsys/c /fsys/d /home/ian -type f > /tmp/files.txt

size = Hash.new

File.open('/tmp/files.txt').each do |f|
    f.chomp!
    f_size = File.size(f)
    if f_size < 1
        # puts "Skipping #{f}; zero size."
        next
    end
    if size.member?(f_size)
        size[f_size].push(f)
    else
        size[f_size] = Array.new
        size[f_size].push(f)
    end
end

def do_checksums(files)
    checksums = Hash.new
    files.each do |file|
        checksum = checksum(file)
        if checksums.member?(checksum)
            checksums[checksum].push(file)
        else
            checksums[checksum] = Array.new
            checksums[checksum].push(file)
        end
    end
    checksums.each do |k, v|
        count = v.size
        if count > 1
            basis = v.pop
            #puts "#{basis} duplicates "+v.join(', ')
            v.each do |copy|
                puts "# Delete #{copy}"
                puts "rm '#{copy}'"
                puts "# Hard link #{basis} at #{copy}."
                puts "ln '#{basis}' '#{copy}'"
                puts
            end

        end
    end

end

size.each do |k,v|
    count = v.size
    if count > 1
        #puts "size #{k} has #{count} elements."
        #puts v.join(', ')
        do_checksums(v)
    end
end

