% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chính Chúa Là Vua" }
  composer = "Tv. 43"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 c8 d |
  c8. g16 a (g) e8 |
  f4 f8 a |
  a8. c16 d,8 d16 (g) |
  d2 |
  c8. d16 c8 d |
  g4. \once \stemDown g8 |
  a8 c e16 (d) c8 |
  d4 r8 \bar "||"
  e8 |
  e4. c8 |
  d4 g,8 g |
  d'4. b8 |
  c4 c8. b16 |
  a8 b c d |
  g,4. f8 |
  e4 g8 a |
  g4. e'8 |
  d8. b16 c _(d) c8 |
  g4 g8 a |
  g4. e'8 |
  d8. b16 b8 d |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*7
  r4.
  
  c8 |
  c4. a8 |
  g4 e8 e |
  f4. g8 |
  e4 e8. g16 |
  fs8 g a f! |
  e4. d8 |
  c4 e8 f |
  e4. c'8 |
  g8. gs16 c8 [f,] |
  e4 e8 f |
  e4. c'8 |
  g8. g16 g8 f |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tai chúng con thường đã được nghe
      truyện cha ông vẫn thường kể lại
      Về công trình tay Chúa thực hiện
      thời các cụ xưa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tay Chúa xưa trục xuất vạn dân,
	    làm tiêu bao giống dòng cả miền
	    Trông dân Ngài vào đó
	    và làm họ lớn mạnh lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tay Chúa đem vinh thắng về đây,
	    làm bao quân ác thù tủi nhục,
	    Ngày lại ngày đoàn con tụng mừng Danh Chúa nào ngơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Sao Chúa nay quên lãng đoàn con,
	    để quân binh thất trận chạy dài,
	    Mặc quân thù dày xéo
	    mà Ngài nào có lợi chi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hay chúng con quên lãng Ngài chăng,
	    hoặc quên giao ước Ngài thuở nào,
	    Hoặc đi trật đường lối
	    mà Ngài đẩy tới diệt vong.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin Chúa mau tỉnh giấc dậy đi,
	    Ngài đang tâm hững hờ ngủ hoài?
	    Đừng xua từ đoàn con,
	    chẳng nhìn ngàn nỗi khổ đau.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Thân chúng con chôn giữa bụi tro,
	    mạng đây bao lớp bùn phủ đầy.
	    Nguyện xin Ngài vùng đứng,
	    dủ tình mà cứu độ cho.
    }
  >>
  \set stanza = "ĐK:"
  Chính Chúa là Vua,
  là Thượng Đế của con,
  đã cho nhà Gia -- cop thắng trận khải hoàn.
  Ngài trợ lực, chúng con quật ngã quân thù.
  Nhờ danh Ngài, chúng con chà đạp đối phương.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
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
  \key c \major \time 2/4
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
