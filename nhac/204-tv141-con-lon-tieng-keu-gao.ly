% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Con Lớn Tiếng Kêu Gào"
  composer = "Tv. 141"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f4 \tuplet 3/2 { a8 a f } |
  d4. df8 |
  c4 \tuplet 3/2 { a'8 bf bf } |
  g4 r8 f16 bf |
  bf4 \tuplet 3/2 { bf8 f bf } |
  c4. a16 f |
  d8. df16 \tuplet 3/2 { c8 g' g } |
  f4 r8 \bar "||" \break
  
  c |
  a'4 \tuplet 3/2 { g8 g g } |
  e8. e16 \tuplet 3/2 { f8 f f } |
  d4. c8 |
  a'8. f16 \tuplet 3/2 { bf8 a f } |
  g4 r8 f16 f |
  bf4 \tuplet 3/2 { g8 bf b! } |
  c4. a16 f |
  d4 \tuplet 3/2 { c8 g' f } |
  f2 ~ |
  f4 r \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*7
  r4.
  c8 |
  f4 \tuplet 3/2 { bf,8 bf bf } |
  c8. c16 \tuplet 3/2 { a8 a a } |
  bf4. c8 |
  f8. d16 \tuplet 3/2 { g8 f d } |
  e4 r8 f16 e |
  d4 \tuplet 3/2 { d8 g f } |
  e4. f16 d |
  bf4 \tuplet 3/2 { a8 bf bf } |
  a2 ~ |
  a4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Con lớn tiếng kêu gào,
      kêu gào xin Chúa xót thương.
      Lời than van thân trình lên Chúa,
      Nỗi niềm nghèo tỏ bày trước Thánh Nhan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ôi Chúa vẫn am tường
	    nẻo đường con dấn bước đi,
	    Dù khi con hao mòn sinh khí,
	    Dẫu quân thù giăng dò lưới khắp nơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bên cánh hữu con này
	    đâu người quen biết, nghĩa thân,
	    Tìm đâu ra nơi mà nương náu,
	    Cũng chẳng gặp ai thèm ngó tới con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Con rất đỗi cơ cùng,
	    xin Ngài thương xót lắng nghe,
	    Giật thân con khỏi bọn uy hiếp,
	    Chúng bạo tàn, hung mạnh quá sức con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Khi thoát chống lao tù,
	    con nguyện cảm mến Thánh Danh.
	    Ngài công minh vui lòng hoan chúc
	    Bởi con được tay Ngài giáng phúc ân.
    }
  >>
  \set stanza = "ĐK:"
  Lạy Chúa, con kêu lên Ngài và xin thân thưa rằng:
  Ngài chính là chốn con ẩn thân,
  là phần riêng dành cho con đó
  chính ngay tại miền đất nhân sinh.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 8\mm
  bottom-margin = 8\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
